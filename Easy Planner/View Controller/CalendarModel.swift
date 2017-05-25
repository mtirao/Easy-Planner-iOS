//
//  CalendarController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/28/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import Foundation

class CalendarModel {
    
    let nameOfMonth = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]
    let nameOfMonthLong = ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"]
    let year : Int
    
    let numColums = 7
    let numRows = 6
    
    var longMonthName = false
    
    init(addYear:Int) {
        let currentCalendar = NSCalendar.current
        let unitFlags = Set<Calendar.Component>([.weekday, .year, .month, .day ])
        var comp = currentCalendar.dateComponents(unitFlags, from: Date())
        
        self.year = comp.year! + addYear
    }
    
    init(year: Int) {
        self.year = year
    }
    
    func isNewMonth(date: Date, day: Int) -> Bool {
        
        let currentCalendar = NSCalendar.current
        let unitFlags = Set<Calendar.Component>([.weekday, .year, .month, .day ])
        var comp = currentCalendar.dateComponents(unitFlags, from: date)
        
        let month = comp.month!
        
        comp.day = day
        let newDate = currentCalendar.date(from: comp)
        
        var comp1 = currentCalendar.dateComponents(unitFlags, from: newDate!)
        let month1 = comp1.month!
        
        return month != month1
    }

    
    func calendarForMonth(month: Int) -> [[Int]] {
        
        let currentCalendar = NSCalendar.current
        
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.month = month
        dateComponents.year = year
        let date = currentCalendar.date(from:dateComponents)
        
        var weekday = currentCalendar.component(.weekday, from: date!)
        
        var calendar : [[Int]] = Array(repeating:Array(repeating:0, count:numColums), count:numRows)
        
        var day = 1
        
        for i in 0..<numRows {
            for j in 0..<numColums {
                
                if j >= (weekday - 1) && !isNewMonth(date: date!, day: day) {
                   calendar[i][j] = day
                   day += 1
                }
            }
            weekday = 0
        }
        
        return calendar
    }
    
    func monthName(month: Int) -> String {
        if month >= 0 && month < 12 {
            if longMonthName {
                return nameOfMonthLong[month];
            } else {
                return nameOfMonth[month];
            }
        }
        
        return "";
    }
    
    func monthCount() -> Int {
        return nameOfMonth.count
    }
    
    func yearAsString() -> String {
        return String(self.year)
    }

}
