//
//  CurrentDayInfoViewViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 25.11.2020.
//

import SwiftUI

final class CurrentDayInfoViewViewModel: ObservableObject {
    @Published private(set) var fastingName = ""
    @Published private(set) var isFasting: FastingEnum = .fasting
    @Published private(set) var roundWeek = ""
    @Published private(set) var voice = ""
    @Published private(set) var weekday = ""
}

enum FastingEnum: String {
    case fasting = "Fasting day"
    case regular = "Regular day"
}
