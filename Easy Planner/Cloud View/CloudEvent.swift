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
    
    
    func saveToCloud(progress:UILabel, completion: @escaping ()->Void) {
        
        let semaphore = DispatchSemaphore(value: 0)
        
        if(Preferences.userToken == "") {
            let loginOperation = SocialClient.defaultClient.login() { loginInfo in
                if let login = loginInfo {
                    Preferences.userToken = login.userToken
                }
                semaphore.signal()
            }
            loginOperation?.resume()
            
            semaphore.wait()
        }
        
        
        if let currentEvent = EventManager.sharedInstance.currentEvent {
            
            if currentEvent.serverId == nil {
                let eventOperation = SocialClient.defaultClient.addEvent(date: (currentEvent.date as Date?)!, name: currentEvent.name!) { eventInfo in
                    if let event = eventInfo {
                        print("\(event.eventId!)")
                        completion()
                        semaphore.signal()
                        currentEvent.serverId = eventInfo?.eventId
                        EventManager.sharedInstance.saveContext()
                    }
                }
                eventOperation?.resume()
            }else {
                semaphore.signal()
                Alert().showAlert(title: "Save Event", message: "This Event was already upload. It will be update.")
            }
        }
        
        semaphore.wait()
    }
}
