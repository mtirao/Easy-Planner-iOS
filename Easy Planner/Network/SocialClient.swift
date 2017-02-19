//
//  SocialClient.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/30/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreLocation

let kSocialServerUrl = "http://127.0.0.1:3000"

class SocialClient: NSObject {
    
    static let defaultClient = SocialClient()
    
    var error : NSError?
    var currentLocation : CLLocation?
    var deviceToken : String = "no-push"

    
    private override init() {
        
    }

    func addEvent(event: Event) {
        
        let resource = kSocialServerUrl + "/addEvent"
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        makeRequest(url: resource, method: .POST, parameters: ["name": event.name ?? "",
                                                               "date": format.string(from: (event.date ?? NSDate()) as Date ) ],
                                                               completion:{ (data) in
                
                if let result = data {
                    
                    let newEventResult = TrackEvent(json: result)
                    
                    if let token = newEventResult.status, token == 200 {
                        self.error = nil
                    }else {
                        self.error = NSError(domain: "social.newEvent", code: 401, userInfo: nil)
                    }
                }else {
                    self.error = NSError(domain: "social.newEvent", code: 400, userInfo: nil)
                }
                
        })
        
    }
    
}
