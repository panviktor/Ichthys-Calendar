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
    
    func deleteSaint(serverID: Int) {
        let index = saints.firstIndex { $0.serverID == serverID }
        if let index = index {
            saints.remove(at: index)
            CoreDataManager.shared.deleteSaint(saint: Int32(serverID))
        }
    }
}

