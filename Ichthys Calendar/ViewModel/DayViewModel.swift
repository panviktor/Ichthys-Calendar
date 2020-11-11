//
//  DayViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 07.11.2020.
//

import Combine
import SwiftUI

class DayViewModel: ObservableObject, CalendarDayService {
    //MARK: - Main Service
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - Date
    let date = Date()
    let theCalendar = Calendar.current
    var dayComponent = DateComponents()
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    var currentDateInt = 0
    
    //MARK: - VM 
    @Published private(set) var holidays = [Holiday]()
    @Published private(set) var saints = [Saint]()
    @Published private(set) var fasting = Fasting()
    
    init(apiSession: APIService = APISession()) {
        self.apiSession = apiSession
    }
    
    func getCalandarDayData()  {
        let cancellable = self.getCalandarDayData()
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
    
    func getNextDayData() {
        currentDateInt += 1
        dayComponent.day = currentDateInt
        let nextDay = theCalendar.date(byAdding: dayComponent, to: date)
        let dateString = dateFormatter.string(from: nextDay!)
        print(dateString)
        getCalandarDayData(from: dateString)
    }
    
    func getPreviousDayData() {
        currentDateInt -= 1
        dayComponent.day = currentDateInt
        let previousDay = theCalendar.date(byAdding: dayComponent, to: date)
        let dateString = dateFormatter.string(from: previousDay!)
        print(dateString)
        getCalandarDayData(from: dateString)
    }
    
    func getTodayData() {
        currentDateInt = 0
        getCalandarDayData()
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
