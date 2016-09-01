//
//  Invitation+CoreDataProperties.swift
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

extension Invitation {

    @NSManaged var heigth: NSNumber?
    @NSManaged var unit: NSNumber?
    @NSManaged var width: NSNumber?
    @NSManaged var event: Event?
    @NSManaged var image: NSSet?
    @NSManaged var text: NSSet?

}
