//
//  DayInfoLoader.swift
//  Ichthys Calendar WidgetExtension
//
//  Created by Viktor on 29.11.2020.
//

import SwiftUI

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
