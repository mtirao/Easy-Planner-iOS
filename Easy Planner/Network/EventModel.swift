//
//  EventModel.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 4/17/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class EventModel: Parser {
    
    
    var eventId: String?
    
    override init(json loginData: Data) {
        super.init(json: loginData)
        
        if let jsonLogin = self.json as? [String:Any] {
            
            self.eventId = jsonLogin["id"] as? String
        }
    }

    
    
}
