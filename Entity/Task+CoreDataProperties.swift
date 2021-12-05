//
//  Task+CoreDataProperties.swift
//  taskify-app
//
//  Created by Ali Ahad
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var detail: String?
    @NSManaged public var hours: Int16
    @NSManaged public var ratePerHour: Int16
    @NSManaged public var status: String?
    @NSManaged public var creationTime: Date?
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?

}

extension Task : Identifiable {

}
