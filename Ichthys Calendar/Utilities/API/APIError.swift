//
//  APIError.swift
//  Ichthys Calendar
//
//  Created by Viktor on 07.11.2020.
//

import Foundation

enum APIError: Error {
    case decodingError
    case httpError(Int)
    case unknown
}
