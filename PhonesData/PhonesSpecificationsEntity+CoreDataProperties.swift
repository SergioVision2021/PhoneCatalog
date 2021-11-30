//
//  PhonesSpecificationsEntity+CoreDataProperties.swift
//  PhonesData
//
//  Created by Apple on 25.11.21.
//
//

import Foundation
import CoreData


extension PhonesSpecificationsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhonesSpecificationsEntity> {
        return NSFetchRequest<PhonesSpecificationsEntity>(entityName: "PhonesSpecificationsEntity")
    }

    @NSManaged public var brand: String?
    @NSManaged public var name: String?
    @NSManaged public var model: String?
    @NSManaged public var release_date: Date?
    @NSManaged public var os: String?
    @NSManaged public var photo: Data?
    @NSManaged public var display: String?
    @NSManaged public var camera: String?
    @NSManaged public var cpu: String?
    @NSManaged public var gpu: String?
    @NSManaged public var ram: String?
    @NSManaged public var storage: String?
    @NSManaged public var battery: String?

}

extension PhonesSpecificationsEntity : Identifiable {

}
