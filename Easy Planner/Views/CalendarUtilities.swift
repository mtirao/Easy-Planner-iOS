//
//  CalendarUtilities.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 3/22/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class CalendarUtil: NSObject {
    
    class func firstHourOfCurrentDate(forDate: Date) -> Date {
        
        let currentCalendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
        var comp = currentCalendar.dateComponents(unitFlags, from: forDate)
        comp.setValue(0, for: .hour)
        comp.setValue(0, for: .minute)
        comp.setValue(0, for: .second)
        
        return currentCalendar.date(from: comp)!
        
    }
    
    class func lastHourOfCurrentDate(forDate: Date) -> Date {
        
        let currentCalendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
        var comp = currentCalendar.dateComponents(unitFlags, from: forDate)
        comp.setValue(23, for: .hour)
        comp.setValue(59, for: .minute)
        comp.setValue(59, for: .second)
        
        
        return currentCalendar.date(from: comp)!
        
    }
    
    class func startOfMonth(forDate: Date) -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: forDate)))!
    }
    
    class func endOfMonth(forDate: Date) -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: CalendarUtil.startOfMonth(forDate: forDate))!
    }
    
}
