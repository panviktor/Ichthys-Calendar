//
//  Ichthys_Calendar_Widget.swift
//  Ichthys Calendar Widget
//
//  Created by Viktor on 28.11.2020.
//

import WidgetKit
import SwiftUI
import Combine

struct DayInfoProvider: TimelineProvider {
    typealias Entry =  DayInfoEntry
    
    func placeholder(in context: Context) -> DayInfoEntry {
        DayInfoEntry(date: Date(), dayInfo: DayInfo.mocDayInfo)
            
    }
    
    func getSnapshot(in context: Context, completion: @escaping (DayInfoEntry) -> ()) {
        let entry = DayInfoEntry(date: Date(), dayInfo: DayInfo.mocDayInfo)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
        
        DayInfoLoader.fetch { result in
            let dayInfo: DayInfo
            
            if case .success(let fetchedDay) = result {
                dayInfo = fetchedDay
            } else {
                dayInfo = DayInfo(weekday: "", dayNumber: "", isFasting: true, fastingName: "Failed to load day info", holiday: "")
            }
            let entry = DayInfoEntry(date: currentDate, dayInfo: dayInfo)
            //FIXME: - fix reloading
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

struct DayInfoEntry: TimelineEntry {
    let date: Date
    let dayInfo: DayInfo
    
    var relevance: TimelineEntryRelevance? {
        return TimelineEntryRelevance(score: 10) // 0 - not important | 100 - very important
    }
}

@main
struct Ichthys_Calendar_Widget: Widget {
    let kind: String = "Ichthys_Calendar_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DayInfoProvider()) { entry in
            Ichthys_Calendar_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Ichthys Calendar Widget")
        .description("Shows the fast day and holiday.")
    }
}


struct DayInfo {
    let weekday: String
    let dayNumber: String
    let isFasting: Bool
    let fastingName: String
    let holiday: String
    
    static var mocDayInfo = DayInfo(weekday: "Среда", dayNumber: "31", isFasting: true,
                                    fastingName: "Рождественский пост", holiday: "Рождественские святки")
}


struct DayInfoLoader {
    static func weekday() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    static func day() -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let day = components.day
        return "\(day ?? 1)"
    }
    
    static func fetch(completion: @escaping (Result<DayInfo, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: CalendarEndpoint.currentDate.urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            let commit = getCommitInfo(fromData: data!)
            completion(.success(commit))
        }
        task.resume()
    }
    
    static func getCommitInfo(fromData data: Foundation.Data) -> DayInfo {
        do {
            let dayData = try JSONDecoder().decode(DayData.self, from: data)
            let weekday = Self.weekday()
            let dayNumber = Self.day()
            let isFasting = dayData.fasting.isFasting
            let fastingName = dayData.fasting.unwrappedFasting
            let holiday = dayData.holidays.first?.unwrappedTitle ?? ""
            return DayInfo(weekday: weekday, dayNumber: dayNumber, isFasting: isFasting, fastingName: fastingName, holiday: holiday)
        } catch let jsonError {
            print(jsonError)
            return DayInfo.mocDayInfo
        }
    }
}


struct Ichthys_Calendar_WidgetEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    
    var entry: DayInfoEntry
    
    var body: some View {
        if widgetFamily == .systemSmall {
            ZStack {
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(entry.dayInfo.weekday)
                                .padding(.bottom, 5)
                            Spacer()
                            Text(entry.dayInfo.dayNumber)
                                .bold()
                                .padding(.bottom, 5)
                        }
                        if entry.dayInfo.isFasting {
                            Text("Fasting")
                                .font(.subheadline).fontWeight(.bold)
                        } else {
                            Text("No fasting")
                                .font(.subheadline).fontWeight(.bold)
                        }
                    }
                    Spacer()
                    Text(entry.dayInfo.fastingName)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Text(entry.dayInfo.holiday)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
        } else {
            VStack {
                Text("This is a medium or large widget")
            }
        }
    }
}


struct Ichthys_Calendar_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Ichthys_Calendar_WidgetEntryView(entry: DayInfoEntry(date: Date(), dayInfo: DayInfo.mocDayInfo))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
