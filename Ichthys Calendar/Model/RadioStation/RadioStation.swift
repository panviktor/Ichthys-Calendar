//
//  RadioStation.swift
//  Ichthys Calendar
//
//  Created by Viktor on 21.12.2020.
//

import Foundation

struct RadioStation: Codable {
    var name: String
    var streamURL: URL
    var description: String
    var longDescription: String
    var stationStringImage: String?
    
    init(name: String, streamURL: URL,  description: String = "",
         longDescription: String = "", stationStringImage: String? = nil) {
        self.name = name
        self.streamURL = streamURL
        self.description = description
        self.longDescription = longDescription
        self.stationStringImage = stationStringImage
    }
}

extension RadioStation: Equatable {
    static func == (lhs: RadioStation, rhs: RadioStation) -> Bool {
        return (lhs.name == rhs.name) && (lhs.streamURL == rhs.streamURL) && (lhs.description == rhs.description) && (lhs.longDescription == rhs.longDescription)
    }
}
