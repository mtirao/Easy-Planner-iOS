//
//  Event+CoreDataProperties.swift
//  
//
//  Created by Marcos Tirao on 4/28/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Event {

    @NSManaged var Date: NSDate?
    @NSManaged var ID: NSNumber?
    @NSManaged var Name: String?
    @NSManaged var Contact: NSOrderedSet?
    @NSManaged var extras: NSSet?
    @NSManaged var food: NSSet?
    @NSManaged var invitation: Invitation?
    @NSManaged var misc: NSSet?
    @NSManaged var music: NSSet?
    @NSManaged var Place: Place?
    @NSManaged var tables: NSSet?

}
