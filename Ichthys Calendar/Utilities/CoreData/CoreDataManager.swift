//
//  CoreDataManager.swift
//
//  Created by Viktor on 20.11.2020.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    private var moc: NSManagedObjectContext
   
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
        self.moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func saveItem(shortName: String, fullName: String, saintDescription: String, serverID: Int) {
        let request: NSFetchRequest<SaintCDM> = SaintCDM.fetchRequest()
        request.predicate = NSPredicate(format: "serverID == %@", String(serverID))
        
        let saint = SaintCDM(context: self.moc)
        saint.id = UUID()
        saint.timestamp = Date()
        saint.serverID = Int32(serverID)
        saint.shortName = shortName
        saint.fullName = fullName
        saint.saintDescription = saintDescription
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchAllSaintCDM() -> [SaintCDM] {
        var allSaints = [SaintCDM]()
        let saintRequest: NSFetchRequest<SaintCDM> = SaintCDM.fetchRequest()
        do {
            allSaints = try self.moc.fetch(saintRequest)
        } catch let error as NSError {
            print(error)
        }
        return allSaints
    }
    
    func fetchSaint(_ serverID: Int32) -> SaintCDM? {
        var saints = [SaintCDM]()
        let request: NSFetchRequest<SaintCDM> = SaintCDM.fetchRequest()
        request.predicate = NSPredicate(format: "serverID == %@", String(serverID))
        
        do {
            saints = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return saints.first
    }
    
    func deleteSaint(saint serverID: Int32) {
        do {
            if let saint = fetchSaint(serverID) {
                self.moc.delete(saint)
                try self.moc.save()
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
