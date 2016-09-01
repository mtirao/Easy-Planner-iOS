//
//  EventMisc.swift
//  
//
//  Created by Marcos Tirao on 4/28/16.
//
//

import Foundation
import CoreData

@objc(EventMisc)
class EventMisc: NSManagedObject {

    
    func addEvent(event:Event) {
        var events: NSMutableSet
        
        events = self.mutableSetValue(forKey: "event")
        events.add(event)
    }
    
    func removeEvent(event: Event) {
        var events: NSMutableSet
        
        events = self.mutableSetValue(forKey: "event")
        events.add(event)
    }


}
