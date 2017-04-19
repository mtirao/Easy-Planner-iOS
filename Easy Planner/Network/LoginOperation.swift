//
//  LoginOperation.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 4/10/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import Foundation

class LoginOperation: Operation {
    
    let userName: String
    let password: String
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
        
        super.init()
    }
    
    override func main() {
        
        if self.isCancelled {
            return
        }
        
        SocialClient.defaultClient.login(completion: { loginInfo in
            
            if let login = loginInfo {
                Preferences.userToken = login.userToken
            }
            
        })
        
    }
    
}
