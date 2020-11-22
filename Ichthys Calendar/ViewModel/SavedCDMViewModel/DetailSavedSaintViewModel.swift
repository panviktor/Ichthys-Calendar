//
//  DetailSavedSaintViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 22.11.2020.
//

import SwiftUI

final class DetailSavedSaintViewModel: ObservableObject {
    let saintServerID: Int
    
    private var saint: SaintCDM! {
        didSet {
            print(#line)
            //FIXME: add to Coredata Unwrapped
            self.name = saint.shortName!
            self.fullName = saint.fullName!
            self.description = saint.saintDescription!

//            self.imageURL = saint.firstValidImgUrl
//            self.imageURLArray = saint.validImageArray


            //FIXME: add to Coredata Unwrapped
            let setCanons = saint.toCanon as! Set<CanonCDM>
            let setPrayer = saint.toPrayer as! Set<PrayerCDM>
            
            self.canons = Array(setCanons)
         self.prayers = Array(setPrayer)
      
//
            
            print(#line, prayers)
            print(#line, canons)
        }
    }

    
    
    
    //MARK: - VM
    @Published private(set) var name = ""
    @Published private(set) var fullName = ""
    @Published private(set) var description = ""

//    @Published private(set) var imageURL: URL?
//    @Published private(set) var imageURLArray: [URL]?

    @Published private(set) var prayers = [PrayerCDM]()
    @Published private(set) var canons = [CanonCDM]()
    
    init(saintServerID: Int) {
        self.saintServerID = saintServerID
    }
    
    func fetchSaint() {
        self.saint = CoreDataManager.shared.fetchSaint(Int32(saintServerID))!
    }
    
}


extension NSSet {
  func toArray<T>() -> [T] {
    let array = self.map({ $0 as! T})
    return array
  }
}
