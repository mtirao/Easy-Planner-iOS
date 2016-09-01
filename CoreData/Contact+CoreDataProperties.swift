//
//  Contact+CoreDataProperties.swift
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

extension Contact {

    @NSManaged var Email: String?
    @NSManaged var Name: String?
    @NSManaged var Phone: String?
    @NSManaged var chair: Chair?
    @NSManaged var Event: Event?

}
