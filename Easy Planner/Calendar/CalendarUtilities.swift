//
//  CalendarUtilities.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 3/22/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import Foundation

class CalendarUtil {
    
    class func string(from date: Date, timeOnly:Bool) -> String{
        
        let formatter = DateFormatter()
        
        if timeOnly {
            formatter.dateFormat = "HH:mm"
        }else  {
            formatter.dateStyle = .medium
        }
        
        return formatter.string(from: date)
        
    }
    
    
    class func mysqlString(from date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = " YYYY-MM-DD HH:mm:SS"
        
        return formatter.string(from: date)
        
    }
    
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
    
    class func startOfYear(forDate: Date) -> Date {
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: forDate)
        dateComponents.day = 1
        dateComponents.month = 1
        
        let date = Calendar.current.date(from: dateComponents)
        
        return date!
    }
    
    class func endOfYear(forDate: Date) -> Date {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: forDate)
        dateComponents.day = 31
        dateComponents.month = 12
        
        let date = Calendar.current.date(from: dateComponents)
        
        return date!

    }
    
    class func dateFromComponents(day: Int, month: Int, year: Int) -> Date {
        
        let dateComponents = DateComponents(calendar: Calendar.current, year: year, month: month, day: day)
        let date = Calendar.current.date(from: dateComponents)
        
        return date!
        
    }

    
}
