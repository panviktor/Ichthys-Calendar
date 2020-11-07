//
//  CalendarEndpoint.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

enum CalendarEndpoint {
    case currentDate
    case currentHoliday
    case certainDay(date: String)
    case certainHoliday(id: Holiday.ID)
    case certainSaint(id: Saint.ID)
    case searchIсon(id: Int)
}

extension CalendarEndpoint: RequestBuilder {
    var urlRequest: URLRequest {
        switch self {
        case .currentDate:
            return .makeForEndpoint("day")
        case .currentHoliday:
            return .makeForEndpoint("holidays")
        case .certainDay(let date):
            return .makeForEndpoint("day/\(date)")
        case .certainHoliday(let id):
            return .makeForEndpoint("holiday/\(id)")
        case .certainSaint(let id):
            return .makeForEndpoint("saint/\(id)")
        case .searchIсon(let id):
            return .makeForEndpoint("ikon/\(id)")
        }
    }
}


