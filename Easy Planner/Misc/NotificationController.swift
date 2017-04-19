//
//  Notification.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/27/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

enum Notes: String {
    
    case codeDataDidInitilizeNotification = "CodeDataDidInitialize"
    case activityIndicatorNotification = "ActivityIndicator"
    
    var notification : Notification.Name  {
        return Notification.Name(rawValue: self.rawValue )
    }
}

class NotificationController{
    
    class func postNotification(name:Notification.Name, userInfo:[NSObject: AnyObject]?) {
        
        NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
        
    }
    
    class func notificationObserver(observer:AnyObject, selector:Selector, name:Notification.Name) {
        
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: nil)
    }

    class func removeObserver(observer:AnyObject) {
        
        NotificationCenter.default.removeObserver(observer)
    }
}

