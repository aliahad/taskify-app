//
//  Location+CoreDataProperties.swift
//  taskify-app
//
//  Created by Ali Ahad
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var city: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var state: String?

}

extension Location : Identifiable {

}
