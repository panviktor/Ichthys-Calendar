//
//  DetailSaintViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import Combine
import SwiftUI

class DetailSaintViewModel: ObservableObject, SaintService {
    var apiSession: APIService
    private var cancellables = Set<AnyCancellable>()
    private let saintID: Int
    private var saint: Saint! {
        didSet {
            print("fetch saint")
            self.name = saint.unwrappedName
            self.fullName = saint.unwrappedTitle
            self.description = saint.unwrappedDescription
            self.metaDescription = saint.unwrappedMetaDescription
            self.imageURL = saint.validImgUrl
        }
    }
    
    //MARK: - VM
    @Published private(set) var name = ""
    @Published private(set) var fullName = ""
    @Published private(set) var description = ""
    @Published private(set) var metaDescription = ""
    @Published private(set) var imageURL: URL?

    init(apiSession: APIService = APISession(), saintID: Int ) {
        self.apiSession = apiSession
        self.saintID = saintID
    }
    
    func getCertainSaint() {
        let cancellable = self.getCertainSaintData(from: saintID)
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