//
//  Fasting.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import Foundation

struct Fasting: Codable {
    let type: Int?

    var fasting: Bool {
        guard let type = type, type == 0 else {
            return false
        }
        return true
    }
    
    enum CodingKeys: String, CodingKey {
        case type
    }
    
    init(type: Int? = nil) {
        self.type = type
    }
}
