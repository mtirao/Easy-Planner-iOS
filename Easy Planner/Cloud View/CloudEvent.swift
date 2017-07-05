//
//  CloudEventViewModel.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 3/28/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class CloudEvent: NSObject {
    
    private var events :[Event]?
    
    private var indexPath : IndexPath = IndexPath(row: 0, section: 0)
    
    func fetchEventsForMonth(month: Date, yearly: Bool) {
        
        var firstDate : Date
        var lastDate : Date
        
        if yearly {
            firstDate = CalendarUtil.startOfYear(forDate: month)
            lastDate = CalendarUtil.endOfYear(forDate: month)
        }else {
            firstDate = CalendarUtil.startOfMonth(forDate: month)
            lastDate = CalendarUtil.endOfMonth(forDate: month)
        }
        
        events = EventManager.sharedInstance.eventsForDate(firstDate: firstDate as NSDate, lastDate: lastDate as NSDate)
        
    }
    
    func count() -> Int {
        return events?.count ?? 0
    }
    
    func eventDetail(atIndexPath: IndexPath) -> (String, String)? {
        
        if let event = events?[atIndexPath.row] {
            
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            
            return (event.name ?? "", formatter.string(from:event.date! as Date))
        }
        
        return nil
    }
    
    func selectCurrent(atIndexPath: IndexPath) {
        self.indexPath = atIndexPath
    }
    
    func eventDetail() -> (String, String)? {
        return eventDetail(atIndexPath: self.indexPath)
    }
    
    
    func saveToCloud() {
        
        let queue = OperationQueue()
        let loginOperation = LoginOperation(userName: Preferences.userName, password: Preferences.password)
        
        loginOperation.completionBlock = {
            print("Completion block:\(loginOperation.userToken)")
        }
        
        queue.addOperation(loginOperation)
        
    }
}