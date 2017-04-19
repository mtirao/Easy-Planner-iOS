//
//  EventOperation.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 4/17/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import Foundation

class EventOperation: Operation {
    
    
    let date: Date
    let eventName: String
    
    init(date: Date, name: String) {
        self.date = date
        self.eventName = name
        
        super.init()
    }
    
    override func main() {
        
        if self.isCancelled {
            return
        }
        
        SocialClient.defaultClient.addEvent(date: self.date, name: self.eventName, completion: { eventInfo in
            
            if let event = eventInfo {
                //EventManager.sharedInstance.currentEvent
                print(event.eventId ?? "Error might ocurred")
            }
            
        })
        
    }
    
}
