//
//  SaintService.swift
//  Ichthys Calendar
//
//  Created by Viktor on 11.11.2020.
//

import Foundation
import Combine

protocol SaintService {
    var apiSession: APIService { get }
    func getCertainSaintData(from certainSaint: Int) -> AnyPublisher<Saint, APIError>
}

extension SaintService {
    func getCertainSaintData(from certainSaint: Int) -> AnyPublisher<Saint, APIError> {
        return apiSession.request(with: CalendarEndpoint.certainSaint(id: certainSaint))
            .eraseToAnyPublisher()
    }
}
