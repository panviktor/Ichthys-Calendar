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

extension Date {
    var weekday: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}
