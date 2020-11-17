//
//  Extension+DateFormatter.swift
//  Ichthys Calendar
//
//  Created by Viktor on 17.11.2020.
//

import Foundation

extension DateFormatter {
    static var dayMonthYear: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
}
