//
//  PrayerCDM+CoreDataProperties.swift
//  Ichthys Calendar
//
//  Created by Viktor on 22.11.2020.
//
//

import Foundation
import CoreData

extension PrayerCDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrayerCDM> {
        return NSFetchRequest<PrayerCDM>(entityName: "PrayerCDM")
    }

    @NSManaged public var id: UUID
    @NSManaged public var type: String?
    public var unwrappedType: String {
        type ?? "Unwrapped Type"
    }
    
    @NSManaged public var text: String?
    public var unwrappedText: String {
        text ?? "Unwrapped Text"
    }
    
    @NSManaged public var toSaint: SaintCDM?
}

extension PrayerCDM : Identifiable {

}
