//
//  DayInfo.swift
//  Ichthys Calendar WidgetExtension
//
//  Created by Viktor on 29.11.2020.
//

import Foundation

struct DayInfo {
    let weekday: String
    let dayNumber: String
    let isFasting: Bool
    let fastingName: String
    let holiday: String
    
    static var mocDayInfo = DayInfo(weekday: "Thursday", dayNumber: "10", isFasting: true,
                                    fastingName: "Christmas fast", holiday: "Icons of the Mother of God called \"Sign\"")
}
