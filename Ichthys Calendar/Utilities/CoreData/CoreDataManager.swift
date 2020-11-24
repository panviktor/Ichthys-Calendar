//
//  CoreDataManager.swift
//
//  Created by Viktor on 20.11.2020.
//

import CoreData
import Combine
import SwiftUI

//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \SaintCDM.timestamp, ascending: true)],
//        animation: .default)
//
//    private var items: FetchedResults<SaintCDM>

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }


class CoreDataManager {
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    private var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
        self.moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    var prayerCDM = [PrayerCDM]()
    var canonCDM = [CanonCDM]()
    var imageCDM = [ImageCDM]()
    
    //MARK: - SaintCDM
    func saveSaint(shortName: String, fullName: String, saintDescription: String, serverID: Int) {
        let request: NSFetchRequest<SaintCDM> = SaintCDM.fetchRequest()
        request.predicate = NSPredicate(format: "serverID == %@", String(serverID))
        
        let saint = SaintCDM(context: self.moc)
        saint.id = UUID()
        saint.timestamp = Date()
        saint.serverID = Int32(serverID)
        saint.shortName = shortName
        saint.fullName = fullName
        saint.saintDescription = saintDescription
        
        prayerCDM.forEach {
            saint.addToToPrayer($0)
        }
        
        canonCDM.forEach {
            saint.addToToCanon($0)
        }
        
        imageCDM.forEach {
            saint.addToToImage($0)
        }
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        imageCDM.removeAll()
        canonCDM.removeAll()
        prayerCDM.removeAll()
    }
    
    func fetchAllSaintCDM() -> [SaintCDM] {
        print(#function, #line)
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
        print(#line, #function)
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
    
    //MARK: - CanonCDM
    func saveCanon(title: String, metaDescription: String, text: String) {
        let canon = CanonCDM(context: self.moc)
        canon.id = UUID()
        canon.title = title
        canon.metaDescription = metaDescription
        canon.text = text
        canonCDM.append(canon)
    }
    
    //MARK: - PrayerCDM
    func savePrayer(type: String, text: String) {
        let prayer = PrayerCDM(context: self.moc)
        prayer.id = UUID()
        prayer.type = type
        prayer.text = text
        prayerCDM.append(prayer)
    }
    
    //MARK: - ImageCDM
    func saveImage(url: URL) {
        var cancellable: AnyCancellable?
        let loader =  ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue)
        let image = ImageCDM(context: self.moc)
        image.id = UUID()
        
        cancellable = loader.$image
            .map {$0?.jpegData(compressionQuality: 1.0) }
            .sink { [weak self] in
                guard let self = self else { return }
                image.image = $0
                if $0 != nil {
                    self.imageCDM.append(image)
                }
            }
        loader.load()
        
        cancellable?.cancel()
    }
}
