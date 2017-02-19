//
//  NewApplication.swift
//  AST Admin
//
//  Created by Marcos Tirao on 6/23/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

class TrackEvent: Parser {
    
    var status: Int?
    var message: String?
    
    override init(json loginData: NSData) {
        super.init(json: loginData)
        
        if let jsonLogin = self.json as? NSDictionary {
            self.status = (jsonLogin.object(forKey: "status") as! NSNumber).intValue
            self.message = jsonLogin.object(forKey: "message") as? String
        }
    }

    
}
