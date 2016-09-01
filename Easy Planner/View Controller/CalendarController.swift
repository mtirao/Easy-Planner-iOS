//
//  CalendarController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/28/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

class CalendarController: UIViewController {

    private let headerHeight : CGFloat = 25
    private let firstDay = 100
    private var currentDate = Date()
    
    private let nameOfMonth = ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"]
    
    private let currentCalendar = NSCalendar.current
    
    private var selectedDay : Day?
    
    private var currentMonth : Int = 0
    private var currentYear : Int = 0
    
    var delegate: CalendarControllerDelegate?
    
    var alreadyLoaded = false
    
    var selectedDate : Date? {
        
        get {
            
            let unitFlags = Set<Calendar.Component>([.year, .month, .day ])
            var comp = currentCalendar.dateComponents(unitFlags, from: Date())
            
            if let day = selectedDay?.number {
                comp.setValue(day, for: .day)
                comp.setValue(currentYear, for: .year)
                comp.setValue(currentMonth, for: .month)
                return currentCalendar.date(from: comp)
            }else {
                return nil
            }

        }
        
        set {
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if alreadyLoaded {
            return
        }
        
        let header = HeaderCalendar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: headerHeight))
        header.backgroundColor = UIColor.white
        header.tag = 0
        self.view.addSubview(header)
        
        let HStep = self.view.frame.size.width / 7
        let VStep = self.view.frame.size.height / 6
        
        var tag = firstDay
        for i in 1...6 {
            for j in 1...7 {
                
                tag += 1
                let day = Day(frame: CGRect(x: CGFloat(j-1) * HStep, y: headerHeight + CGFloat(i-1)*VStep, width: HStep, height: VStep) )
                day.backgroundColor = UIColor.white
                day.tag = tag
                day.delegate = self
                self.view.addSubview(day)
                
            }
        }
        
        calendarForCurrentDate()
        
        alreadyLoaded = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func upSwipe(_ sender: AnyObject) {
        upOneMonth()
    }

    @IBAction func downSwipe(_ sender: AnyObject) {
        downOneMonth()
    }
    
    
}

//MARK: - Calendar delegate protocol
extension CalendarController : CalendarDelegate {
    
    func didSelectDay(day: Day) {
        
        self.selectedDay?.selected = false
        self.selectedDay?.setNeedsDisplay()
        
        day.selected = true
        day.setNeedsDisplay()
        
        self.selectedDay = day
        
        self.delegate?.daySelectionChange(selected: true)
        
    }
    
}

//MARK: - Calendar Methods
extension CalendarController {
    
    func setToday() {
        self.currentDate = Date()
        self.calendarForCurrentDate()
    }
    
    func firstDateOfCurrentMonth() -> Date {
        
        let unitFlags = Set<Calendar.Component>([.weekday, .year, .month, .day ])
        
        var comp = currentCalendar.dateComponents(unitFlags, from: self.currentDate)
        comp.setValue(1, for: .day)
        
        return currentCalendar.date(from: comp)!
    }

    func isNewMonth(date: Date, day: Int) -> Bool {
        
        let unitFlags = Set<Calendar.Component>([.weekday, .year, .month, .day ])
        var comp = currentCalendar.dateComponents(unitFlags, from: date)
        
        let month = comp.month!
        
        comp.day = day
        let newDate = currentCalendar.date(from: comp)
        
        var comp1 = currentCalendar.dateComponents(unitFlags, from: newDate!)
        let month1 = comp1.month!
        
        return month != month1
    }
    
    func calendarForCurrentDate() {
        
        let firstDateOfCurrentMonth = self.firstDateOfCurrentMonth()
        
        let unitFlags = Set<Calendar.Component>([.weekday, .year, .month, .day ])
        var comp = currentCalendar.dateComponents(unitFlags, from: firstDateOfCurrentMonth)
       
        
        let weekday = comp.weekday!
        let month = comp.month!
        let year = comp.year!
        
        self.currentYear = year
        self.currentMonth = month
        
        self.navigationController?.navigationBar.topItem?.title = "\(self.nameOfMonth[month-1]) \(year)"
        
        var tag = firstDay
        var dayValue = 1
        
        comp = currentCalendar.dateComponents(unitFlags, from: Date())
        
        for view in self.view.subviews {
            if !isNewMonth(date: firstDateOfCurrentMonth, day: dayValue) {
                if let day = view as? Day {
                    if day.tag >= firstDay + weekday {
                        day.number = dayValue
                        if dayValue == comp.day! && month == comp.month! && year == comp.year! {
                            day.today = true
                        }
                        day.setNeedsDisplay()
                        dayValue += 1
                    }
                    tag += 1
                
                }
            }else {
                break
            }
            
        }
        
    }
    
    func clearDay() {
        
        for view in self.view.subviews {
            if view.tag >= firstDay && view.tag <= firstDay + 42 {
                if let day = view as? Day {
                    day.number = 0
                    day.selected = false
                    day.today = false
                    day.setNeedsDisplay()
                }
                
            }
        }
        
    }
    
    func upOneMonth() {
        
        clearDay()
        

        self.currentDate = currentCalendar.date(byAdding: .month, value: 1, to: self.currentDate)!
        
        self.calendarForCurrentDate()
        
        self.delegate?.daySelectionChange(selected: false)
        
    }
    
    func downOneMonth() {
        
        clearDay()
        
        self.currentDate = currentCalendar.date(byAdding: .month, value: -1, to: self.currentDate)!
        
        self.calendarForCurrentDate()
        
        self.delegate?.daySelectionChange(selected: false)
        
    }
    
}
