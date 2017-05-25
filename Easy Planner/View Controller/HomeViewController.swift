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
let addEventSegue = "addEventSegue"
let eventDetailSegue = "eventDetailSegue"
let cloudEventSegue = "cloudEventSegue"

enum TableViewTag : Int {
    case event = 1
    case calendar = 0
}

class HomeViewController: UIViewController, CalendarControllerDelegate {
    
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var month: MonthView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var calendarViewHeight: NSLayoutConstraint!
    
    
    var calendarModel : CalendarModel?
    var selectedMonth :  Int?
    
    var events :[Event]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = Theme.barTint
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.month.dataMonth(calendarModel: calendarModel!, forMonth: selectedMonth!)
        
        AppDelegate.trackInit(value: "HomeViewController")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.trackExit(value: "HomeVIewController")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == addEventSegue {
            
            /*if let date = self.calendarController?.selectedDate {
                EventManager.sharedInstance.createEvent(forDate: date)
            }*/
            
        }else if segue.identifier == eventDetailSegue {
            
            if let selectedCell = self.eventTableView.indexPathForSelectedRow {
                
                EventManager.sharedInstance.currentEvent = self.events?[selectedCell.row]
                
            }
            
        }else if segue.identifier == cloudEventSegue {
            /*if let cloudEvent = segue.destination as? CloudEventViewController {
                cloudEvent.selectedDate = self.calendarController?.selectedDate ?? self.calendarController?.currentDate
            }*/
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == addEventSegue {
            //return calendarController?.selectedDate != nil
        }
        
        return true
        
    }
    
    func loadEvents(forDate: Date) {
        DispatchQueue.main.async(execute: {
            
            let firstDate = CalendarUtil.firstHourOfCurrentDate(forDate: forDate)
            let lastDate = CalendarUtil.lastHourOfCurrentDate(forDate: forDate)
            
            self.events = EventManager.sharedInstance.eventsForDate(firstDate: firstDate as NSDate, lastDate: lastDate as NSDate)
            self.eventTableView?.reloadData()
            
        })

    }
    
    func daySelectionChange(selected: Bool) {
        self.addButton.isEnabled = selected
        
        self.events?.removeAll()
        
        if selected {
           /* if let selectedDate = self.calendarController?.selectedDate {
                self.loadEvents(forDate: selectedDate)
            } */
        }else {
            self.eventTableView?.reloadData()
        }
        
    }
    
    func adjustHeight(height: Int) {
       
    }

    
    
}

// MARK: - Action method
extension HomeViewController {
    
    
    
    @IBAction func todayAction(_ sender: AnyObject) {
        
        //self.calendarController?.setToday()
        
    }
    
    @IBAction func cloudAction(_ sender: AnyObject) {
    }
}

// MARK: - Table view datasource methods
extension HomeViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if tableView.tag == TableViewTag.calendar.rawValue {
            return false;
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if tableView.tag == TableViewTag.event.rawValue {
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
        
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == TableViewTag.event.rawValue {
            return self.events?.count ?? 0
        }else {
            return 1;
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == TableViewTag.event.rawValue {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: homeEventCell) as? HomeTableViewCell
        
            if let event = self.events?[indexPath.row] {
            
                cell?.eventName.text = event.name ?? ""
            
                cell?.eventTime.text = DateHelper.string(from: event.date! as Date , timeOnly: true)
            
                if let place = event.place {
                
                    cell?.eventLoc.text = "\(place.City ?? "Some City"), \(place.Address ?? "Some Address")"
                
                }
            }
        
            return cell!
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell")
            
            return cell!
            
        }
        
        
        
    }
    
}

