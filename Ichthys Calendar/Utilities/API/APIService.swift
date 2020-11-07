//
//  APIService.swift
//  Ichthys Calendar
//
//  Created by Viktor on 07.11.2020.
//

import Foundation
import Combine

protocol APIService {
    func request<T: Decodable>(with builder: RequestBuilder) -> AnyPublisher<T, APIError>
}
