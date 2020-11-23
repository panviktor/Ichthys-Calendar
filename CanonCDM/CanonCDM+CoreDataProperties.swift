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

    @NSManaged public var id: UUID
    
    @NSManaged public var title: String?
    public var unwrappedTitle: String {
        title ?? "Unwrapped Title"
    }
    
    @NSManaged public var metaDescription: String?
    public var unwrappedMetaDescription: String {
        metaDescription ?? "Unwrapped MetaDescription"
    }
    
    @NSManaged public var text: String?
    public var unwrappedText: String {
        text ?? "Unwrapped Full Name"
    }
    
    @NSManaged public var toSaint: SaintCDM?
}

extension CanonCDM : Identifiable {}
