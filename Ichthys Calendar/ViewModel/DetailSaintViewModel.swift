//
//  DetailSaintViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import Combine
import SwiftUI

class DetailSaintViewModel: ObservableObject, CalendarService {
    struct UnwrapedDetailSaint {
        
    }
    
    
    private var cancellables = Set<AnyCancellable>()
    var apiSession: APIService
    
    @Published var saint: Saint?
    
    init(apiSession: APIService = APISession(), saintID: Int? = nil ) {
        self.apiSession = apiSession
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




