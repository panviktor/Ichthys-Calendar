//
//  DayData.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

// MARK: - DayData
struct DayData: Codable {
    let saints: [Saint]
    let holidays: [Holiday]
}
