//
//  DataController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/27/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData

class DataController: NSObject {
    
    var initalized : Bool = false
    
    let persistentContainer : NSPersistentContainer
    
    init() {
        
        persistentContainer = NSPersistentContainer(name: "DataModel")
        initalized = false
        
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                self.initalized = false
                fatalError("Failed to load Core Data stack: \(error)")
            }else {
                self.initalized = true
            }
            
            NotificationController.postNotification(name: Notes.codeDataDidInitilizeNotification.notification, userInfo: nil)
        }
    }
    

    func saveContext () {
        
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}
