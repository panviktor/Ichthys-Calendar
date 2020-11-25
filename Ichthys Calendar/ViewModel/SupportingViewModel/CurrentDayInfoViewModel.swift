//
//  CurrentDayInfoViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 25.11.2020.
//

import SwiftUI

final class CurrentDayInfoViewModel: ObservableObject {
    @Published private(set) var fastingName = ""
    @Published private(set) var isFasting = true
    @Published private(set) var roundWeek = ""
    @Published private(set) var voice = ""
    @Published private(set) var weekday = ""
    
    init(date: Date, fating: Fasting) {
        self.weekday = weekday(date: date)
    }
    
    private func weekday(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}

