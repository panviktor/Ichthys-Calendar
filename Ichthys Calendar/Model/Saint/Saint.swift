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
    var unwrappedID: Int {
        id ?? 1
    }
    
    let name: String?
    var unwrappedName: String {
        name ?? "Name"
    }
    
    let title: String?
    var unwrappedTitle: String {
        title ?? "Title"
    }
    
    let titleGenitive: String?
    var unwrappedtitleGenitive: String {
        titleGenitive ?? "titleGenitive"
    }
    
    let typeOfSanctity: String?
    var unwrappedTypeOfSanctity: String {
        typeOfSanctity ?? "Type of Sanctity"
    }
    
    let churchTitle: String?
    var unwrappedChurchTitle: String {
        churchTitle ?? "Church Title"
    }
    
    let churchTitleGenitive: String?
    var unwrappedChurchTitleGenitive: String {
        churchTitleGenitive ?? "Church Title Genitive"
    }
    
    let typeOfSanctityPlural: String?
    var unwrappedTypeOfSanctityPlural: String {
        typeOfSanctityPlural ?? "Type of Sanctity Plural"
    }
    
    let churchTitlePlural: String?
    var unwrappedChurchTitlePlural: String {
        churchTitlePlural ?? "Church Title Plural"
    }
    
    let typeOfSanctityComplete: String?
    var unwrappedTypeOfSanctityComplete: String {
        typeOfSanctityComplete ?? "Type Of Sanctity Complete"
    }
        
    let typeOfSanctityCompleteFemale: String?
    var unwrappedTypeOfSanctityCompleteFemale: String {
        typeOfSanctityCompleteFemale ?? "Type Of Sanctity Complete Female"
    }
    
    let enableChurchTitle: Int?
    var unwrappedEnableChurchTitle: Int {
        enableChurchTitle ?? 0
    }
        
    let enableTypeOfSanctity: Int?
    var unwrappedEnableTypeOfSanctity: Int {
        enableTypeOfSanctity ?? 0
    }
    
    let saintPrefix: String?
    var unwrappedSaintPrefix: String {
        saintPrefix ?? "Saint Prefix"
    }
    
    let suffix: String?
    var unwrappedSuffix: String {
        suffix ?? "Suffix"
    }
    
    let description: String?
    var unwrappedDescription: String {
        description?.html2String ?? "Description"
    }

    let metaDescription: String?
    var unwrappedMetaDescription: String {
        metaDescription?.html2String ?? "Description"
    }
    
    let imgs: [SaintImg]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case title
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
        case description
        case metaDescription = "meta_description"
        case imgs
    }
    
    var validImgUrl: URL? {
        guard let img = imgs?.first else {
            return nil
        }
        
        guard let imgSaintID = img.saintid, let imgImage = img.image,
              let url = URL(string: "https://cdn.azbyka.ru/days/assets/img/saints/\(imgSaintID)/\(imgImage)") else {
            return nil
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
