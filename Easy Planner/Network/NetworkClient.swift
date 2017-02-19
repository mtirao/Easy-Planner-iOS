//
//  NetworkClient.swift
//  AST Admin
//
//  Created by Marcos Tirao on 5/26/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreLocation

let kServerUrl = "http://127.0.0.1:3000"
let kAppId = "12345678"


class NetworkClient: NSObject, Network {
    
    static let defaultClient = NetworkClient()
    
    var error : NSError?
    var currentLocation : CLLocation?
    var deviceToken : String = "no-push"
    
    var uuid : String {
        get {
            if let server = UserDefaults.standard.string(forKey: "app_token") {
                return server
            }else {
                let uuid = NSUUID().uuidString
                UserDefaults.standard.setValue(uuid, forKey: "app_token")
                return uuid
            }
        }
    }

    private override init() {
        
    }
    
    func trackEvent(eventName: String, eventValue: String) {
        
        let resource = kServerUrl + "/addEvent"
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let platform = ProcessInfo.processInfo
        
        let latitude = currentLocation?.coordinate.latitude ?? 0
        let longitude = currentLocation?.coordinate.longitude ?? 0
        
        
        makeRequest(url: resource, method: .POST, parameters: ["event_name": eventName,
            "event_value" : eventValue,
            "app_id": kAppId,
            "date": format.string(from: NSDate() as Date),
            "region": "",
            "platform": "MacOS " + platform.operatingSystemVersionString,
            "latitude": "\(latitude)",
            "longitude": "\(longitude)",
            "app_token": uuid,
            "user_token": deviceToken],  completion:{ (data) in
            
            if let result = data {
                
                let newEventResult = TrackEvent(json: result)
                
                if let token = newEventResult.status, token == 200 {
                    self.error = nil
                }else {
                    self.error = NSError(domain: "astadmin.newEvent", code: 401, userInfo: nil)
                }
            }else {
                self.error = NSError(domain: "astadmin.newEvent", code: 400, userInfo: nil)
            }
            
        })
    }

}
