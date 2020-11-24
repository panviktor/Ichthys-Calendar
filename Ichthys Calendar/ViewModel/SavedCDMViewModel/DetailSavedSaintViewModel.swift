//
//  DetailSavedSaintViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 22.11.2020.
//

import SwiftUI

final class DetailSavedSaintViewModel: ObservableObject {
    let saintServerID: Int
    
    private var saint: SaintCDM? {
        didSet {
            if let saint = self.saint {
                self.name = saint.unwrappedShortName
                self.fullName = saint.unwrappedFullName
                self.description = saint.unwrappedSaintDescription
                
                self.canons = saint.unwrappedToCanon
                self.prayers = saint.unwrappedToPrayer
                
                let setImages = saint.unwrappedToImage
                self.images = setImages.compactMap { $0.image }.compactMap { UIImage(data: $0) }
            }
            print(#line, #function, "something going wrong")
        }
    }
    
    //MARK: - VM
    @Published private(set) var name = ""
    @Published private(set) var fullName = ""
    @Published private(set) var description = ""
    
    @Published private(set) var images = [UIImage]()
    @Published private(set) var prayers = [PrayerCDM]()
    @Published private(set) var canons = [CanonCDM]()
    
    init(saintServerID: Int) {
        self.saintServerID = saintServerID
    }
    
    func fetchSaint() {
        self.saint = CoreDataManager.shared.fetchSaint(Int32(saintServerID))
    }
}
