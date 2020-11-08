//
//  Holiday.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

// MARK: - Holiday
struct Holiday: Codable {
    let item: String?
    let id: Int?
    let title: String?
    let metaDescription: String?
    let imgs: [HolidayImg]?
    
    var unwrappedTitle: String {
        return title ?? "Title not found"
    }
    
    enum CodingKeys: String, CodingKey {
        case item
        case id
        case title
        case metaDescription = "meta_description"
        case imgs
    }
}

extension Holiday: Identifiable {}

extension Holiday: Equatable {
    static func == (lhs: Holiday, rhs: Holiday) -> Bool {
        lhs.id == rhs.id
    }
}
