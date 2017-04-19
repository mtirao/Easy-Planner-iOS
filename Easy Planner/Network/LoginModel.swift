//
//  Login.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 4/4/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class LoginModel: Parser {
    
    var userToken: String?
    
    override init(json loginData: Data) {
        super.init(json: loginData)
        
        if let jsonLogin = self.json as? [String:Any] {
            
            self.userToken = jsonLogin["id"] as? String
        }
    }

    
}
