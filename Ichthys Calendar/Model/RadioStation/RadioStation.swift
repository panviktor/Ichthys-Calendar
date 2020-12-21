//
//  RadioStation.swift
//  Ichthys Calendar
//
//  Created by Viktor on 21.12.2020.
//

import Foundation

struct RadioStation: Codable {
    var name: String
    var streamURL: String
    var description: String
    var longDescription: String
    
    init(name: String, streamURL: String, imageURL: String, description: String, longDescription: String = "") {
        self.name = name
        self.streamURL = streamURL
        self.description = description
        self.longDescription = longDescription
    }
}

extension RadioStation: Equatable {
    static func == (lhs: RadioStation, rhs: RadioStation) -> Bool {
        return (lhs.name == rhs.name) && (lhs.streamURL == rhs.streamURL) && (lhs.description == rhs.description) && (lhs.longDescription == rhs.longDescription)
    }
}
