//
//  SaintCDM+CoreDataProperties.swift
//  Ichthys Calendar
//
//  Created by Viktor on 23.11.2020.
//
//

import Foundation
import CoreData


extension SaintCDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaintCDM> {
        return NSFetchRequest<SaintCDM>(entityName: "SaintCDM")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var saintDescription: String?
    @NSManaged public var serverID: Int32
    @NSManaged public var shortName: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var toCanon: NSSet?
    @NSManaged public var toImage: NSSet?
    @NSManaged public var toPrayer: NSSet?

}

// MARK: Generated accessors for toCanon
extension SaintCDM {

    @objc(addToCanonObject:)
    @NSManaged public func addToToCanon(_ value: CanonCDM)

    @objc(removeToCanonObject:)
    @NSManaged public func removeFromToCanon(_ value: CanonCDM)

    @objc(addToCanon:)
    @NSManaged public func addToToCanon(_ values: NSSet)

    @objc(removeToCanon:)
    @NSManaged public func removeFromToCanon(_ values: NSSet)

}

// MARK: Generated accessors for toImage
extension SaintCDM {

    @objc(addToImageObject:)
    @NSManaged public func addToToImage(_ value: ImageCDM)

    @objc(removeToImageObject:)
    @NSManaged public func removeFromToImage(_ value: ImageCDM)

    @objc(addToImage:)
    @NSManaged public func addToToImage(_ values: NSSet)

    @objc(removeToImage:)
    @NSManaged public func removeFromToImage(_ values: NSSet)

}

// MARK: Generated accessors for toPrayer
extension SaintCDM {

    @objc(addToPrayerObject:)
    @NSManaged public func addToToPrayer(_ value: PrayerCDM)

    @objc(removeToPrayerObject:)
    @NSManaged public func removeFromToPrayer(_ value: PrayerCDM)

    @objc(addToPrayer:)
    @NSManaged public func addToToPrayer(_ values: NSSet)

    @objc(removeToPrayer:)
    @NSManaged public func removeFromToPrayer(_ values: NSSet)

}

extension SaintCDM : Identifiable {

}
