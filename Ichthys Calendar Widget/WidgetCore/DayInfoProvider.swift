//
//  DayInfoProvider.swift
//  Ichthys Calendar WidgetExtension
//
//  Created by Viktor on 29.11.2020.
//

import WidgetKit
import SwiftUI

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
        let truncated = Calendar.current.startOfDay(for: Date())
        let nextUpdate = Calendar.autoupdatingCurrent.date(byAdding: .day, value: 1,
                                                           to: Calendar.autoupdatingCurrent.startOfDay(for: truncated))!
        
        DayInfoLoader.fetch { result in
            let dayInfo: DayInfo
            if case .success(let fetchedDay) = result {
                dayInfo = fetchedDay
            } else {
                dayInfo = DayInfo(weekday: "", dayNumber: "", isFasting: true,
                                  fastingName: "Failed to load day info", holiday: "")
            }
            let entry = DayInfoEntry(date: currentDate, dayInfo: dayInfo)
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
    }
}
