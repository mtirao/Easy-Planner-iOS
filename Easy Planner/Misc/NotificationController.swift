//
//  Notification.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/27/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

let codeDataDidInitilize = "CodeDataDidInitialize"

class NotificationController: NSObject {
    
    class func postNotification(name:String, userInfo:[NSObject: AnyObject]?) {
        
        NotificationCenter.default.post(name: NSNotification.Name(name), object: nil, userInfo: userInfo)
        
    }
    
    class func notificationObserver(observer:AnyObject, selector:Selector, name: NSNotification.Name) {
        
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: nil)
    }
    
}
