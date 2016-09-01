//
//  Tables+CoreDataProperties.swift
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

extension Tables {

    @NSManaged var height: NSNumber?
    @NSManaged var number: NSNumber?
    @NSManaged var persons: NSNumber?
    @NSManaged var posx: NSNumber?
    @NSManaged var posy: NSNumber?
    @NSManaged var type: NSNumber?
    @NSManaged var width: NSNumber?
    @NSManaged var chair: NSSet?
    @NSManaged var event: Event?

}