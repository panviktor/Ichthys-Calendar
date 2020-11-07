//
//  Holiday.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

// MARK: - Holiday
struct Holiday: Codable {
    let id: Int
    let title: String?
    let imgs: [HolidayImg]?
    
    var unwrappedTitle: String {
       return title ?? "Title not found"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case imgs
    }
}

extension Holiday: Identifiable {}

extension Holiday: Equatable {
    static func == (lhs: Holiday, rhs: Holiday) -> Bool {
        lhs.id == rhs.id
    }
}
