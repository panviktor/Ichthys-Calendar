//
//  Fasting.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import Foundation

struct Fasting: Codable {
    let type: Int?
    var isFasting: Bool {
        guard let type = type, type == 0 else {
            return false
        }
        return true
    }
    
    //Fasting Name
    let fasting: String?
    var unwrappedFasting: String {
        fasting ?? ""
    }
    
    let roundWeek: String?
    var unwrappedRoundWeek: String {
        roundWeek ?? ""
    }
    
    let voice: Int?
    var unwrappedVoice: String {
        "Voice \(voice ?? 1)"
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case fasting
        case roundWeek = "round_week"
        case voice
    }
    
    init(type: Int? = nil, fasting: String? = nil, roundWeek: String? = nil, voice: Int? = nil) {
        self.type = type
        self.fasting = fasting
        self.roundWeek = roundWeek
        self.voice = voice
    }
}
