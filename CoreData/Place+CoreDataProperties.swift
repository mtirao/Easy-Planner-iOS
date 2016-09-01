//
//  Place+CoreDataProperties.swift
//  
//
//  Created by Marcos Tirao on 5/6/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Place {

    @NSManaged var Address: String?
    @NSManaged var City: String?
    @NSManaged var Country: String?
    @NSManaged var Name: String?
    @NSManaged var price: NSDecimalNumber?
    @NSManaged var priceGroup: NSNumber?
    @NSManaged var State: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var Event: NSSet?

}
