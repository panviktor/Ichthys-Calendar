//
//  HolidayImg.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

// MARK: - HolidayImg
struct HolidayImg: Codable {
    let id: Int?
    let holidayid: Int?
    let image: String?
    let preview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case holidayid = "holiday_id"
        case image
        case preview
    }
}
