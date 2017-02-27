//
//  HomeViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/26/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

let homeEventCell = "homeEventCell"

//MARK: - Segue indentifiers
let embededCalendarSegue = "embededCalendarSegue"
let addEventSegue = "addEventSegue"
let eventDetailSegue = "eventDetailSegue"

class HomeViewController: UIViewController, CalendarControllerDelegate {
    
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var calendarController : CalendarController?
    
    var events :[Event]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = Theme.barTint
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedDate = calendarController?.selectedDate {
            loadEvents(forDate: selectedDate)
        }else {
            loadEvents(forDate: Date())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == embededCalendarSegue {
            
            self.calendarController = segue.destination as? CalendarController
            self.calendarController?.delegate = self
        }else if segue.identifier == addEventSegue {
            
            if let date = self.calendarController?.selectedDate {
                EventManager.sharedInstance.createEvent(forDate: date)
            }
            
        }else if segue.identifier == eventDetailSegue {
            
            if let selectedCell = self.eventTableView.indexPathForSelectedRow {
                
                EventManager.sharedInstance.currentEvent = self.events?[selectedCell.row]
                
            }
            
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == addEventSegue {
            return calendarController?.selectedDate != nil
        }
        
        return true
        
    }
    
    func loadEvents(forDate: Date) {
        DispatchQueue.main.async(execute: {
            
            let firstDate = self.firstDateOfCurrentMonth(forDate: forDate)
            let lastDate = self.lastDateOfCurrentMonth(forDate: forDate)
            
            self.events = EventManager.sharedInstance.eventsForDate(firstDate: firstDate as NSDate, lastDate: lastDate as NSDate)
            self.eventTableView?.reloadData()
            
        })

    }
    
    func daySelectionChange(selected: Bool) {
        self.addButton.isEnabled = selected
        
        self.events?.removeAll()
        
        if selected {
            if let selectedDate = self.calendarController?.selectedDate {
                self.loadEvents(forDate: selectedDate)
            }
        }else {
            self.eventTableView?.reloadData()
        }
        
    }
    
    
}

// MARK: - Action method
extension HomeViewController {
    
    
    
    @IBAction func todayAction(_ sender: AnyObject) {
        
        self.calendarController?.setToday()
        
    }
    
    @IBAction func cloudAction(_ sender: AnyObject) {
    }
}

// MARK: - Table view datasource methods
extension HomeViewController: UITableViewDataSource {
    
    
    func firstDateOfCurrentMonth(forDate: Date) -> Date {
        
        let currentCalendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
        var comp = currentCalendar.dateComponents(unitFlags, from: forDate)
        comp.setValue(0, for: .hour)
        comp.setValue(0, for: .minute)
        comp.setValue(0, for: .second)
        
        return currentCalendar.date(from: comp)!
        
    }
   
    func lastDateOfCurrentMonth(forDate: Date) -> Date {
        
        let currentCalendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
        var comp = currentCalendar.dateComponents(unitFlags, from: forDate)
        comp.setValue(23, for: .hour)
        comp.setValue(59, for: .minute)
        comp.setValue(59, for: .second)
        
        
        return currentCalendar.date(from: comp)!

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            if let event = self.events?[indexPath.row] {
                EventManager.sharedInstance.deleteEvent(event: event)
                self.events?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        default: break
            
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return self.events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: homeEventCell) as? HomeTableViewCell
        
        if let event = self.events?[indexPath.row] {
            
            cell?.eventName.text = event.name ?? ""
            
            cell?.eventTime.text = DateHelper.string(from: event.date! as Date , timeOnly: true)
            
            if let place = event.place {
                
                cell?.eventLoc.text = "\(place.City ?? ""), \(place.Address ?? "")"
                
            }
        }
        
        return cell!
        
    }
    
}

