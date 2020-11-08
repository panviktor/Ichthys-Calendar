//
//  HolidayImg.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

// MARK: - HolidayImg
struct HolidayImg: Codable {
    let id, holidayid: Int?
    let image: String?
    let priority: Int?
    let imgDescription, preview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case holidayid = "holiday_id"
        case image, priority
        case imgDescription = "description"
        case preview
    }
}
