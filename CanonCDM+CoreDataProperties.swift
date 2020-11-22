//
//  CanonCDM+CoreDataProperties.swift
//  Ichthys Calendar
//
//  Created by Viktor on 22.11.2020.
//
//

import Foundation
import CoreData


extension CanonCDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CanonCDM> {
        return NSFetchRequest<CanonCDM>(entityName: "CanonCDM")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var metaDescription: String?
    @NSManaged public var text: String?
    @NSManaged public var toSaint: SaintCDM?

}

extension CanonCDM : Identifiable {

}
