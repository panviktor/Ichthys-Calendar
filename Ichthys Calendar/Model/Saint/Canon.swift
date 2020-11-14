//
//  Canon.swift
//  Ichthys Calendar
//
//  Created by Viktor on 12.11.2020.
//

import Foundation

struct Canon: Codable {
    let id: Int?
    var unwrappedID: Int {
        id ?? 1
    }
    
    let type: String?
    let subtype: Int?
    
    let text: String?
    var unwrappedText: String {
        text?.html2StringCustomREGLite ?? "Text"
    }
    
    let title: String?
    var unwrappedTitle: String {
        title ?? "Title"
    }
    
    let titleShort: String?

    
    let metaDescription: String?
    var unwrappedMetaDescription: String {
        metaDescription ?? "Title"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case subtype
        case text
        case title
        case titleShort = "title_short"
        case metaDescription = "meta_description"
    }
}

extension Canon: Identifiable {}
