//
//  HolidayViewViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 26.11.2020.
//

import SwiftUI

final class HolidayViewViewModel: ObservableObject {

    //MARK: - VM
    @Published private(set) var holidays: [Holiday] {
        didSet {
            print(#line)
        }
    }
    
    init(holidays: [Holiday]) {
        print(#line, #function, holidays)
        self.holidays = holidays
    }
}
