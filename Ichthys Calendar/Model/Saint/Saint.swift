//
//  Saint.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

// MARK: - Saint
struct Saint: Codable {
    let id: Int?
    let name: String?
    let title: String?
    let titleGenitive: String?
    let typeOfSanctity: String?
    let churchTitle, churchTitleGenitive: String?
    let typeOfSanctityPlural: String?
    let churchTitlePlural: String?
    let typeOfSanctityComplete, typeOfSanctityCompleteFemale: String?
    let enableChurchTitle, enableTypeOfSanctity: Int?
    let saintPrefix: String??
    let suffix: String?
    let dateid: Int?
    let imgs: [SaintImg]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, title
        case titleGenitive = "title_genitive"
        case typeOfSanctity = "type_of_sanctity"
        case churchTitle = "church_title"
        case churchTitleGenitive = "church_title_genitive"
        case typeOfSanctityPlural = "type_of_sanctity_plural"
        case churchTitlePlural = "church_title_plural"
        case typeOfSanctityComplete = "type_of_sanctity_complete"
        case typeOfSanctityCompleteFemale = "type_of_sanctity_complete_female"
        case enableChurchTitle = "enable_church_title"
        case enableTypeOfSanctity = "enable_type_of_sanctity"
        case saintPrefix = "prefix"
        case suffix
        case dateid = "date_id"
        case imgs
    }
    
    var validImgUrl: URL {
        guard let img = imgs?.first else {
            return URL(string: "https://cdn.azbyka.ru/")!
        }
        guard let url = URL(string: "https://cdn.azbyka.ru/days/assets/img/saints/\(img.saintid ?? 00)/\(img.image ?? "")") else {
            return URL(string: "https://cdn.azbyka.ru/")!
        }
        return url
    }
}

extension Saint: Identifiable {}

extension Saint: Equatable {
    static func == (lhs: Saint, rhs: Saint) -> Bool {
        lhs.id == rhs.id
    }
}
