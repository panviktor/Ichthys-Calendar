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
        text?.html2String ?? "Text"
    }
    
    let title: String?
    var unwrappedTitle: String {
        title ?? "Title"
    }
    
    let titleShort: String?
    let voice: String?
    let file: String?
    
    let metaDescription: String?
    var unwrappedMetaDescription: String {
        metaDescription ?? "Title"
    }
    
    let redirecturl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case subtype
        case text
        case title
        case titleShort = "title_short"
        case voice
        case file
        case metaDescription = "meta_description"
        case redirecturl = "redirect_url"
    }
}
