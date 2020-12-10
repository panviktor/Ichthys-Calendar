//
//  SavedSaintViewModel.swift
//  Ichthys Calendar
//
//  Created by Viktor on 21.11.2020.
//

import SwiftUI
import Combine

class SavedSaintViewModelList: ObservableObject {
    //MARK: - VM
    private var allSaints = [SaintCDM]() {
        didSet {
            self.filteredSaints = allSaints
        }
    }
    
    @Published var searchText = ""
    @Published private(set) var filteredSaints: [SaintCDM] = [SaintCDM]()
    
    private var publisher: AnyCancellable?
    
    init() {
        self.filteredSaints = allSaints
        
        self.publisher = $searchText
            .receive(on: RunLoop.main)
            .sink(receiveValue: { str in
                if !self.searchText.isEmpty {
                    self.filteredSaints = self.allSaints.filter {
                        $0.unwrappedShortName.contains(str)
                    }
                } else {
                    self.filteredSaints = self.allSaints
                }
            })
    }
    
    func updateScreen() {
        allSaints = CoreDataManager.shared.fetchAllSaintCDM()
    }
    
    func deleteSaint(serverID: Int) {
        let index = allSaints.firstIndex { $0.serverID == serverID }
        if let index = index {
            allSaints.remove(at: index)
            CoreDataManager.shared.deleteSaint(saint: Int32(serverID))
        }
    }
}

