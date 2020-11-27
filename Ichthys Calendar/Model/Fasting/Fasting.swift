//
//  Fasting.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import Foundation

struct Fasting: Codable {
    let type: Int?
    private var unwrappedType: Int {
        guard let type = type else {
            return 0
        }
        return type
    }
    
    var isFasting: Bool {
        unwrappedType != 1 ? false : true
    }
    
    //Fasting Name
    let fasting: String?
    var unwrappedFasting: String {
        fasting ?? ""
    }
    
    let roundWeek: String?
    var unwrappedRoundWeek: String {
        roundWeek?.html2String ?? ""
    }
    
    let voice: Int?
    var unwrappedVoice: String {
        "\(voice ?? 1)"
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
