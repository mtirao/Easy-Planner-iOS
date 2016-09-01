//
//  Music+CoreDataProperties.swift
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

extension Music {

    @NSManaged var album: String?
    @NSManaged var artist: String?
    @NSManaged var compositeName: String?
    @NSManaged var name: String?
    @NSManaged var event: NSSet?

}
