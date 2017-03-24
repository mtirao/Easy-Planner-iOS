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
    
    override init(json loginData: Data) {
        super.init(json: loginData)
        
        if let jsonLogin = self.json as? [String:Any] {
            
            let status = jsonLogin["status"] as! NSString
            self.status = status.integerValue
            
            self.message = jsonLogin["message"] as? String
        }
    }

    
}
