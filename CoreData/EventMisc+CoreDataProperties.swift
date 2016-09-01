//
//  EventMisc+CoreDataProperties.swift
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

extension EventMisc {

    @NSManaged var address: String?
    @NSManaged var contact: String?
    @NSManaged var name: String?
    @NSManaged var note: String?
    @NSManaged var price: NSDecimalNumber?
    @NSManaged var priceGroup: NSNumber?
    @NSManaged var type: NSNumber?
    @NSManaged var event: NSSet?

}
