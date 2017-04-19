//
//  SocialClient.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/30/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import Foundation


class SocialClient {
    
    static let defaultClient = SocialClient()
    
    var error : NSError?
    
    private let appId = "1ac1df94-bb2b-45aa-b55b-d96cdb080945"
    private let secret = "70f68c46-c96b-4ba8-8d4d-8554f6ac481c"
    
    let kSocialServerUrl = "https://social-argsoftsolutions.rhcloud.com"
    
    private init() {
        
    }

    func login(completion:@escaping (LoginModel?) -> Void) {
        
        let resource = kSocialServerUrl + "/login"
        
        let parameters : [String : String] = ["appId" : appId,
                                              "appToken" : Preferences.appToken!,
                                              "email" : "",
                                              "password" : Preferences.password,
                                              "phone" : "",
                                              "secretId" : secret]
        
        makeRequest(url: resource, parameters: parameters) {data in
            
            if let response = data {
                
                let login = LoginModel(json: response)
                completion(login)
            }else {
                completion(nil)
            }
            
        }
        
    }
    
    func addEvent(date: Date, name: String, completion:@escaping (EventModel?) -> Void) {
        
        let resource = kSocialServerUrl + "/createEvent"
        
        let parameters : [String : String] = ["name" : name,
                                              "date" : DateHelper.mysqlString(from: date)]
        
        makeRequest(url: resource, parameters: parameters) {data in
            
            if let response = data {
                
                let login = EventModel(json: response)
                completion(login)
            }else {
                completion(nil)
            }
            
        }

        
    }
    
}
