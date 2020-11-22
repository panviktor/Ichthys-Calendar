//
//  DetailSaintViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 09.11.2020.
//

import Combine
import SwiftUI

final class DetailSaintViewModel: ObservableObject, SaintService {
    var apiSession: APIService
    private var cancellables = Set<AnyCancellable>()
    private let saintID: Int
    private var saint: Saint! {
        didSet {
            self.name = saint.unwrappedName
            self.fullName = saint.unwrappedTitle
            self.description = saint.unwrappedDescription
            
            self.imageURL = saint.firstValidImgUrl
            self.imageURLArray = saint.validImageArray
        }
    }
    
    //MARK: - VM
    @Published private(set) var name = ""
    @Published private(set) var fullName = ""
    @Published private(set) var description = ""
    
    @Published private(set) var imageURL: URL?
    @Published private(set) var imageURLArray: [URL]?
    
    @Published private(set) var prayers = [Prayer]()
    @Published private(set) var canons = [Canon]()
    
    init(apiSession: APIService = APISession(), saintID: Int) {
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
            }) { [weak self] saint in
                guard let self = self else { return }
                self.saint = saint
                self.prayers = saint.unwrappedPrayers
                self.canons = saint.unwrappedCanons
            }
        cancellables.insert(cancellable)
    }
    
    func saveSaintToCoreData() {
        prayers.forEach { prayer in
            CoreDataManager.shared.savePrayer(type: prayer.unwrappedType, text: prayer.unwrappedText)
        }
        canons.forEach { canon in
            CoreDataManager.shared.saveCanon(title: canon.unwrappedTitle, metaDescription: canon.unwrappedMetaDescription, text: canon.unwrappedText)
        }
        CoreDataManager.shared.saveSaint(shortName: name, fullName: fullName, saintDescription: description, serverID: saintID)
    }
}
