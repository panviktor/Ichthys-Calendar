//
//  Extension+URLRequest.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

extension URLRequest {
    static func makeForEndpoint(_ endpoint: String) -> URLRequest {
        guard let url = URL(string: "https://azbyka.ru/days/api/\(endpoint).json") else {
            preconditionFailure("Invalid URL format")
        }
        let request = URLRequest(url: url)
        return request
    }
}
