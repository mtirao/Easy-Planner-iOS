//
//  Tracking.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 3/8/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreLocation

enum TrackEventType: String {
    
    case Init = "Init"
    case Exit = "Exit"
    
}

class Tracking: NSObject {
    
    var location: CLLocation?
    let appId: String
    
    let plaform: String
    let region: String
    let appToken: String
    
    private let url = "https://tracking-argsoftsolutions.rhcloud.com/addEvent"
    
    private let userName = "1ac1df94-bb2b-45aa-b55b-d96cdb080945"
    private let password = "70f68c46-c96b-4ba8-8d4d-8554f6ac481c"
    
    init(appId: String, appToken:String) {
       
        
        self.region = (NSLocale.current.regionCode) ?? ""
        
        let currentDevice = UIDevice()
        
        self.plaform = "\(currentDevice.systemName)\(currentDevice.systemName)\(currentDevice.model)"
        self.appId = appId
        self.appToken = appToken
        
        super.init()
        
    }
    
    private func trackEvent(value:String, event: TrackEventType) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let params = ["app_id" : self.appId,
                      "event_name" : event.rawValue,
                      "event_value" : value,
                      "date": formatter.string(from: Date()),
                      "latitude": "\(location?.coordinate.latitude ?? 0)",
            "longitude": "\(location?.coordinate.longitude ?? 0)",
            "region":self.region,
            "platform":self.plaform,
            "app_token":self.appToken]
        
        makeRequest(url: url, parameters: params, completion: { (data) in
            
            
        })
    }
    
    func trackInitEvent(value:String) {
        
        trackEvent(value:value, event: TrackEventType.Init)
        
    }
    
    func trackExitEvent(value:String) {
        
        trackEvent(value:value, event: TrackEventType.Exit)
        
    }
    
    
}
