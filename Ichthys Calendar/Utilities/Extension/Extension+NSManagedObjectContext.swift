//
//  Extension+NSManagedObjectContext.swift
//  Ichthys Calendar
//
//  Created by Viktor on 21.11.2020.
//

import CoreData

extension NSManagedObjectContext {
    static var current : NSManagedObjectContext {
        let manager = PersistenceManager.shared
        return manager.persistentContainer.viewContext
    }
}
