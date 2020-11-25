//
//  Extension+Date.swift
//  Ichthys Calendar
//
//  Created by Viktor on 17.11.2020.
//

import Foundation

extension Date {
    static func daysFromToday(_ days: Int) -> Date {
        Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * days))
    }
}

extension Date {
    var dayMonthYear: String {
        DateFormatter.dayMonthYear.string(from: self)
    }
}
