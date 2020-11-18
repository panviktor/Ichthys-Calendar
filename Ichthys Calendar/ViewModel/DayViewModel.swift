//
//  DayViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 07.11.2020.
//

import Combine
import SwiftUI

final class DayViewModel: ObservableObject, CalendarDayService {
    //MARK: - Main Service
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - VM
    let interval = Date.daysFromToday(-365 * 2) ... Date.daysFromToday(+365)
    @Published var date = Date() {
        didSet {
            componentsFromDate(date: date)
            getSelectedDayData(date: date)
        }
    }
    
    @Published private(set) var holidays = [Holiday]()
    @Published private(set) var saints = [Saint]()
    @Published private(set) var fasting = Fasting()
    
    //MARK: - Date
    private var calendar = Calendar.current
    private var year = 2020
    private var month = 11
    private var day = 2

    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
        self.componentsFromDate(date: date)
    }
    
    //MARK: - Main Public method
    func getTodayData() {
        date = Date()
        getCalandarDayData(from: date.dayMonthYear)
    }
    
    func getNextDayData() {
        let newDate = daysFromToday( +1)
        componentsFromDate(date: newDate)
        date = newDate
    }
    
    func getPreviousDayData() {
        let newDate = daysFromToday( -1)
        componentsFromDate(date: newDate)
        date = newDate
    }
    
    //MARK: - Main Private method
    private func componentsFromDate(date: Date) {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        year = components.year ?? 2020
        month = components.month ?? 11
        day = components.day ?? 2
    }
    
    private func getSelectedDayData(date: Date) {
        getCalandarDayData(from: date.dayMonthYear)
    }
    
    private func daysFromToday(_ days: Int) -> Date {
        dateFromComponents().addingTimeInterval(TimeInterval(60 * 60 * 24 * days))
    }
    
    private func dateFromComponents() -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return calendar.date(from: components)!
    }
    
    private func getCalandarDayData(from certainDay: String) {
        let cancellable = self.getCalandarDayData(from: certainDay)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
            }) { dayData in
                self.saints = dayData.saints
                self.holidays = dayData.holidays
                self.fasting = dayData.fasting
            }
        cancellables.insert(cancellable)
    }
}
