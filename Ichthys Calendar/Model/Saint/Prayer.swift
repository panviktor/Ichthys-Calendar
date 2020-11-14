//
//  Prayer.swift
//  Ichthys Calendar
//
//  Created by Viktor on 12.11.2020.
//

import Foundation

struct Prayer: Codable {
    let id: Int?
    var unwrappedID: Int {
        id ?? 1
    }
    
    let type: String?
    var unwrappedType: String {
        type ?? "Type"
    }
    
    let text: String?
    var unwrappedText: String {
        text?.html2StringCustomREG ?? "Unwrapped Text"
    }
    
    let title: String?
    var unwrappedTitle: String {
        title ?? "Title"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case text
        case title
    }
}

extension Prayer: Identifiable {}
