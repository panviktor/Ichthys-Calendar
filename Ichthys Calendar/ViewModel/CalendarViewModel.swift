//
//  CalendarViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 07.11.2020.
//

import Combine
import SwiftUI

class CalendarViewModel: ObservableObject, CalendarService {
    var apiSession: APIService
    var cancellables = Set<AnyCancellable>()
    
    var date = Date()
    var currentDateInt = 0
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    var dayComponent = DateComponents()
    let theCalendar = Calendar.current
    
    @Published var holidays = [Holiday]()
    @Published var saints = [Saint]()
    @Published var fasting: Fasting = Fasting()
    
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
                //FIXME: Fix model!
                self.saints = dayData.saints
                
                self.holidays = dayData.holidays!
                self.fasting = dayData.fasting!
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
                //FIXME: Fix model!
                self.saints = dayData.saints
                self.holidays = dayData.holidays!
                self.fasting = dayData.fasting!
            }
        cancellables.insert(cancellable)
    }
}
