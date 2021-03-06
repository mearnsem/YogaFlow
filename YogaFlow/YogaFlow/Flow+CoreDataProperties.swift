//
//  Flow+CoreDataProperties.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/18/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Flow {

    @NSManaged var name: String
    @NSManaged var notes: String?
    @NSManaged var timestamp: NSDate
    @NSManaged var poses: NSOrderedSet

}
