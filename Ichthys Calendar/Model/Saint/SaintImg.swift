//
//  SaintImg.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

// MARK: - SaintImg
struct SaintImg: Codable {
    let id: Int
    let title, image: String
    let saintid, priority: Int
    let imgDescription: String
    let onlyMain: Int
    let preview: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, image
        case saintid = "saint_id"
        case priority
        case imgDescription = "description"
        case onlyMain = "only_main"
        case preview
    }
}
