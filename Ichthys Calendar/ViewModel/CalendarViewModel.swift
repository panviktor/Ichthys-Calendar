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
    
    @Published var holidays = [Holiday]()
    @Published var saints = [Saint]()
    
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
//                self.holidays = dayData.holidays
               self.saints = dayData.saints
            }
        cancellables.insert(cancellable)
    }
}
