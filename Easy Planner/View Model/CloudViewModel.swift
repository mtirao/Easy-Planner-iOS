//
//  CloudViewModel.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 3/22/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class CloudViewModel: NSObject {
    
    class func eventsForMonth(month: Date) -> [Event] {
        
        let firstDate = CalendarUtil.startOfMonth(forDate: month)
        let lastDate = CalendarUtil.lastHourOfCurrentDate(forDate: month)
        
        return EventManager.sharedInstance.eventsForDate(firstDate: firstDate as NSDate, lastDate: lastDate as NSDate)
        
    }

}
