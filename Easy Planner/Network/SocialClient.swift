//
//  SocialClient.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/30/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import Foundation
import UIKit


class SocialClient {
    
    static let defaultClient = SocialClient()
    
    var error : NSError?
    
    private let appId = "1ac1df94-bb2b-45aa-b55b-d96cdb080945"
    private let secret = "70f68c46-c96b-4ba8-8d4d-8554f6ac481c"
    private let platform = "\(UIDevice.current.systemName)\(UIDevice.current.systemName)\(UIDevice.current.model)"
    
    let kSocialServerUrl = "https://social-argsoftsolutions.rhcloud.com/api/v1"
    
    private init() {
        
    }

    func login(completion:@escaping (LoginModel?) -> Void) -> URLSessionDataTask? {
        
        let resource = kSocialServerUrl + "/login"
        
        let parameters : [String : String] = ["app_id" : appId,
                                              "app_token" : Preferences.appToken!,
                                              "email" : "",
                                              "password" : Preferences.password,
                                              "phone" : "",
                                              "secret_id" : secret]
        
        let dataTask = makeRequest(url: resource, parameters: parameters) {data in
            
            if let response = data {
                
                let login = LoginModel(json: response)
                completion(login)
            }else {
                completion(nil)
            }
            
        }
        
        return dataTask
        
    }
    
    func addEvent(date: Date, name: String, completion:@escaping (EventModel?) -> Void) -> URLSessionDataTask? {
        
        let resource = kSocialServerUrl + "/createEvent"
        
        let parameters : [String : String] = ["platform" : platform,
                                              "event_name" : name,
                                              "date" : CalendarUtil.mysqlString(from: date),
                                              "user_token" : Preferences.userToken ?? "invalid"]
        
        let dataTask = makeRequest(url: resource, parameters: parameters) {data in
            
            if let response = data {
                
                let login = EventModel(json: response)
                completion(login)
            }else {
                completion(nil)
            }
            
        }
        
        return dataTask
        
    }
    
}
