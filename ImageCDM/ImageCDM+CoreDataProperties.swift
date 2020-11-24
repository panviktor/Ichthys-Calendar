//
//  ImageCDM+CoreDataProperties.swift
//  Ichthys Calendar
//
//  Created by Viktor on 23.11.2020.
//
//

import Foundation
import CoreData

extension ImageCDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageCDM> {
        return NSFetchRequest<ImageCDM>(entityName: "ImageCDM")
    }

    @NSManaged public var image: Data?
    @NSManaged public var id: UUID
    @NSManaged public var toSaint: SaintCDM?
}

extension ImageCDM : Identifiable {

}
