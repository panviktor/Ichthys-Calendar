//
//  RadioStation.swift
//  Ichthys Calendar
//
//  Created by Viktor on 21.12.2020.
//

import Foundation

struct RadioStation: Codable {
    let id: Int
    let name: String
    let streamURL: URL
    let description: String
    let longDescription: String
    let stationImage: String?
    
    init(id: Int, name: String, streamURL: URL,  description: String = "",
         longDescription: String = "", stationStringImage: String? = nil) {
        self.id = id
        self.name = name
        self.streamURL = streamURL
        self.description = description
        self.longDescription = longDescription
        self.stationImage = stationStringImage
    }
}

extension RadioStation: Equatable {
    static func == (lhs: RadioStation, rhs: RadioStation) -> Bool {
        return (lhs.id == rhs.id) && (lhs.name == rhs.name) && (lhs.streamURL == rhs.streamURL)
    }
}
