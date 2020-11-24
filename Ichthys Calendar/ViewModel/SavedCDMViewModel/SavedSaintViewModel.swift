//
//  SavedSaintViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 21.11.2020.
//

import SwiftUI

class SavedSaintViewModelList: ObservableObject {
    //MARK: - VM
    @Published private(set) var saints = [SaintCDM]()
    
    func updateScreen() {
        saints = CoreDataManager.shared.fetchAllSaintCDM()
    }
    
    func deleteSaint(index: Int) {
        let serverID = saints[index].serverID
        saints.remove(at: index)
        CoreDataManager.shared.deleteSaint(saint: Int32(serverID))
    }
}

