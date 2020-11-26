//
//  DayData.swift
//  Ichthys Calendar
//
//  Created by Viktor on 06.11.2020.
//

import Foundation

// MARK: - DayData
struct DayData: Codable {
    let saints: [Saint]
    let holidays: [Holiday]
    let fasting: Fasting
    
    private enum CodingKeys: String, CodingKey { case saints, holidays, fasting }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fasting = try container.decode(Fasting.self, forKey: .fasting)
        
        do {
            saints = try container.decode([Saint].self, forKey: .saints)
        } catch DecodingError.typeMismatch {
            saints = [Saint]()
        }

        do {
            holidays = try container.decode([Holiday].self, forKey: .holidays)
        } catch DecodingError.typeMismatch {
            holidays = [Holiday]()
        }
    }
}
