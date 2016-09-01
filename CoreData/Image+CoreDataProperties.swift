//
//  Image+CoreDataProperties.swift
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

extension Image {

    @NSManaged var file: String?
    @NSManaged var heigth: NSNumber?
    @NSManaged var posx: NSNumber?
    @NSManaged var posy: NSNumber?
    @NSManaged var width: NSNumber?
    @NSManaged var invitation: Invitation?

}
