//
//  TaskProposal+CoreDataProperties.swift
//  taskify-app
//
//  Created by Ali Ahad
//
//

import Foundation
import CoreData


extension TaskProposal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskProposal> {
        return NSFetchRequest<TaskProposal>(entityName: "TaskProposal")
    }

    @NSManaged public var status: String?
    @NSManaged public var submissionTime: Date?

}

extension TaskProposal : Identifiable {

}
