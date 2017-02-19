//
//  DateHelper.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/14/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

class DateHelper: NSObject {
    
    class func string(from date: Date, timeOnly:Bool) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: date)
        
    }
    
}
