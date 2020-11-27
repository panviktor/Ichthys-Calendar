//
//  CurrentDayInfoViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 25.11.2020.
//

import SwiftUI

final class CurrentDayInfoViewModel: ObservableObject {

    //MARK: - VM
    @Published private(set) var fastingName = ""
    @Published private(set) var isFasting = true
    @Published private(set) var roundWeek = ""
    @Published private(set) var voice = ""
    @Published private(set) var weekday = ""
    
    init(date: Date, dayInfo: Fasting) {
        self.weekday = weekday(date: date)
        self.fastingName = dayInfo.unwrappedFasting
        self.isFasting = dayInfo.isFasting

        DispatchQueue.main.async {
            self.roundWeek = dayInfo.unwrappedRoundWeek
        }
      
        self.voice = "Voice " + dayInfo.unwrappedVoice
    }
    
    private func weekday(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}

