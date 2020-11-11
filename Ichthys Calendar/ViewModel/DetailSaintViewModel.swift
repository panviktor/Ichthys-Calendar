//
//  DetailSaintViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import Combine
import SwiftUI

class DetailSaintViewModel: ObservableObject, CalendarService {
    var apiSession: APIService
    private var cancellables = Set<AnyCancellable>()
    private var saint: Saint!
    private let saintID: Int
    
    init(apiSession: APIService = APISession(), saintID: Int ) {
        self.apiSession = apiSession
        self.saintID = saintID
    }
    
    func getCertainSaint(id: Int) {
        let cancellable = self.getCertainSaintData(from: id)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
            }) { saint in
                self.saint = saint
            }
        cancellables.insert(cancellable)
    }
}
