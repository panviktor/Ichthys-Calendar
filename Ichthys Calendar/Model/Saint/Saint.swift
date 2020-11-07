//
//  Saint.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

// MARK: - Saint
struct Saint: Codable {
    let id: Int
    let name: String?
    let title: String?
    let titleGenitive: String?
    let newmartyr, priority: Int?
    let uri, url, linkToService, worldlyActivities: String?
    let number, group, splitGroup, combinedGroup: Int?
    let hideIdeograph: Int?
    let typeOfSanctity: String?
    let churchTitle, churchTitleGenitive: String?
    let typeOfSanctityPlural: String?
    let churchTitlePlural: String?
    let typeOfSanctityComplete, typeOfSanctityCompleteFemale: String?
    let enableChurchTitle, enableTypeOfSanctity: Int?
    let saintPrefix: String??
    let suffix: String?
    let dateid: Int?
    let ideograph, bold, isCathedral, saintsDatesStatsFltr: Int?
    let imgs: [SaintImg]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, title
        case titleGenitive = "title_genitive"
        case newmartyr, priority, uri, url
        case linkToService = "link_to_service"
        case worldlyActivities = "worldly_activities"
        case number, group
        case splitGroup = "split_group"
        case combinedGroup = "combined_group"
        case hideIdeograph = "hide_ideograph"
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
        case ideograph, bold
        case isCathedral = "is_cathedral"
        case saintsDatesStatsFltr = "saints_dates_stats_fltr"
        case imgs
    }
}

extension Saint: Identifiable {}
