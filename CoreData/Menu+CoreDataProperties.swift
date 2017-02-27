//
//  Menu+CoreDataProperties.swift
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

extension Menu {

    @NSManaged var menuname: String?
    @NSManaged var price: NSDecimalNumber?
    @NSManaged var event: Event?
    @NSManaged var option: NSSet?

}
