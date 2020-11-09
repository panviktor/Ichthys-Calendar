//
//  CalendarService.swift
//  Ichthys Calendar
//
//  Created by Viktor on 07.11.2020.
//

import Foundation
import Combine

protocol CalendarService {
    var apiSession: APIService { get }
    func getCalandarDayData() -> AnyPublisher<DayData, APIError>
}

extension CalendarService {
    func getCalandarDayData() -> AnyPublisher<DayData, APIError> {
        return apiSession.request(with: CalendarEndpoint.currentDate)
            .eraseToAnyPublisher()
    }
    
    func getCalandarDayData(from certainDay: String) -> AnyPublisher<DayData, APIError> {
        return apiSession.request(with: CalendarEndpoint.certainDay(date: certainDay))
            .eraseToAnyPublisher()
    }
    
    //FIXME: Split Protocol
    func getCertainSaintData(from certainSaint: Int) -> AnyPublisher<Saint, APIError> {
        return apiSession.request(with: CalendarEndpoint.certainSaint(id: certainSaint))
            .eraseToAnyPublisher()
    }
}
