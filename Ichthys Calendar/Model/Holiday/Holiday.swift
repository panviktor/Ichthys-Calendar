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
    let title: String
//    let daysBefore, daysAfter, marked, priority: Int
//    let url, uri, temples, theology: String
//    let iconography, liturgicalFeatures: String
//    let ideograph: Int
//    let pagetitle: String
//    let favorite: Int
//    let datepickerClass, metaDescription: String
//    let urlBase: Int
//    let fullTitle: String
    let imgs: [HolidayImg]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
//        case daysBefore = "days_before"
//        case daysAfter = "days_after"
//        case marked, priority, url, uri, temples, theology, iconography
//        case liturgicalFeatures = "liturgical_features"
//        case ideograph, pagetitle, favorite
//        case datepickerClass = "datepicker_class"
//        case metaDescription = "meta_description"
//        case urlBase = "url_base"
//        case fullTitle = "full_title"
      case imgs
    }
}

extension Holiday: Identifiable {}
