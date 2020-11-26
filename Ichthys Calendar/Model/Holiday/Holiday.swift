//
//  Holiday.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

// MARK: - Holiday
struct Holiday: Codable {
    let item: String?
    let id: Int
    let title: String?
    var unwrappedTitle: String {
        return title ?? "Title not found"
    }
    
    let metaDescription: String?
    var unwrappedMetaDescription: String {
        return metaDescription ?? "Meta description not found"
    }
    
    //FIXME: - Bad Strings!
    //let description: String?
    //var unwrappedDescription: String {
    //        return description ?? "Description not found"
    //}
    
    let imgs: [HolidayImg]?
    
    enum CodingKeys: String, CodingKey {
        case item
        case id
        case title
        case metaDescription = "meta_description"
        //case description
        case imgs
    }
    
        static  let mocHolidays: [Holiday] = [Holiday(item: "Item_1metaDescription_3metaDescription_3metaDescription_3metaDescription_3metaDescription_3metaDescription_3metaDescription_3", id: 1, title: "Title_1", metaDescription: "metaDescription_1metaDescription_3metaDescription_3metaDescription_3", imgs: nil),
                                              Holiday(item: "Item_1", id: 2, title: "Title_2", metaDescription: "metaDescription_2", imgs: nil),
                                              Holiday(item: "Item_3", id: 3, title: "Title_3", metaDescription: "metaDescription_3", imgs: nil)]
}

extension Holiday: Identifiable {}

extension Holiday: Equatable {
    static func == (lhs: Holiday, rhs: Holiday) -> Bool {
        lhs.id == rhs.id
    }
}
