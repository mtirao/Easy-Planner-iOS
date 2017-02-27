//
//  Option+CoreDataProperties.swift
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

extension Option {

    @NSManaged var text: String?
    @NSManaged var name: String?
    @NSManaged var menu: Menu?

}
