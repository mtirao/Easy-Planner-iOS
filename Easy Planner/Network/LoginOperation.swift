//
//  LoginOperation.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 4/10/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import Foundation

class LoginOperation: Operation {
    
    private let userName: String
    private let password: String
    var userToken : String = ""
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
        
        super.init()
    }
    
    override func main() {
        
        if self.isCancelled {
            return
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        
        SocialClient.defaultClient.login(completion: { loginInfo in
            
            if let login = loginInfo {
                self.userToken = login.userToken!
                print("User Token:\(self.userToken)" )
            }
            
            semaphore.signal()
            
        })
        
        semaphore.wait()
    }
    
}
