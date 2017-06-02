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
let cloudSegue = "cloudSegue"

enum TableViewTag : Int {
    case event = 1
    case calendar = 0
}

class HomeViewController: UIViewController, CalendarViewDelegate {
    
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var month: MonthView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var calendarViewHeight: NSLayoutConstraint!
    
    
    var calendarModel : CalendarModel?
    var selectedMonth :  Int?
    
    var selectedDate : Date?
    
    var events :[Event]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = Theme.barTint
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addButton.isEnabled = false
        self.month.dataMonth(calendarModel: calendarModel!, forMonth: selectedMonth!, delegate: self)
        
        AppDelegate.trackInit(value: "HomeViewController")
        
        if self.selectedDate == nil && (self.calendarModel?.today(month: self.selectedMonth! + 1))! {
            self.selectedDate = Date()
        }
        
        
        //self.eventTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.eventTableView.bounds.size.width, height: 0))
        
        self.eventTableView.contentInset = UIEdgeInsetsMake(-80, 0, 0, 0);
        loadEvents(forDate: self.selectedDate)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.trackExit(value: "HomeVIewController")
        
        self.selectedDate = nil
        
        self.month.removeAllMonth()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == eventDetailSegue {
            
            if let selectedCell = self.eventTableView.indexPathForSelectedRow {
                
                EventManager.sharedInstance.currentEvent = self.events?[selectedCell.row]
                
            }
            
        }else if segue.identifier == cloudSegue {
            if let cloudEvent = segue.destination as? CloudEventViewController, let date = self.selectedDate {
                cloudEvent.selectedDate = date
            }
        }
        
    }
    
    
    func loadEvents(forDate: Date?) {
        
        guard let date = forDate else {
            return
        }
        
        DispatchQueue.main.async(execute: {
            
            let firstDate = CalendarUtil.firstHourOfCurrentDate(forDate: date)
            let lastDate = CalendarUtil.lastHourOfCurrentDate(forDate: date)
            
            self.events = EventManager.sharedInstance.eventsForDate(firstDate: firstDate as NSDate, lastDate: lastDate as NSDate)
            self.eventTableView?.reloadData()
            
        })

    }
   
    
    func didSelectDate(day: Int, month: Int, year: Int) {
        
        self.addButton.isEnabled = true
        
        let date = CalendarUtil.dateFromComponents(day: day, month: month, year: year)
        
        self.selectedDate = date
        
        loadEvents(forDate: date)
        
        print("Selected Date: \(day)/\(month)/\(year)")
        
        
    }
    
}

// MARK: - Action method
extension HomeViewController {
    
    @IBAction func addEventAction(_ sender: AnyObject) {

        EventManager.sharedInstance.createEvent(forDate: self.selectedDate!)
        loadEvents(forDate: self.selectedDate!)
        
    }
    
    
}

// MARK: - Table view datasource methods
extension HomeViewController: UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "EVENTS FOR SELECTED DAY"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
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
  
        return self.events?.count ?? 0

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: homeEventCell) as? HomeTableViewCell
        
        if let event = self.events?[indexPath.row] {
            
            cell?.eventName.text = event.name ?? ""
            
            cell?.eventTime.text = CalendarUtil.string(from: event.date! as Date , timeOnly: true)
            
            if let place = event.place {
                
                cell?.eventLoc.text = "\(place.City ?? "Some City"), \(place.Address ?? "Some Address")"
                
            }
        }
        
            return cell!

        
    }
    
}

