//
//  HomeViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/26/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

let homeEventCell = "homeEventCell"

class HomeViewController: UIViewController, CalendarViewDelegate {
    
    var eventTableView: UITableView?
    var month: MonthView?
    var addButton: UIBarButtonItem?
    
    
    var calendarModel : CalendarModel?
    var selectedMonth :  Int?
    
    var selectedDate : Date?
    
    var events :[Event]?
    
    var mainEventViewController : MainEventViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = Theme.barTint
        self.view.backgroundColor = UIColor.white
        
        
        month = MonthView(frame:CGRect.zero)
        month?.fontSize = 17
        month?.headerTopSpacing = 4
        month?.headerLeftSpacing = 24
        month?.longMonthName = true
        month?.monthTopSpacing = 10
        month?.dayName = true
        
        
        self.view.addSubview(month!)
        self.month!.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            make.height.equalTo(230)
            make.top.equalTo(64)
        }
        
        eventTableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.view.addSubview(eventTableView!)
        let nib : UINib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        eventTableView!.register(nib, forCellReuseIdentifier: homeEventCell)
        eventTableView!.delegate = self
        eventTableView!.dataSource = self
        eventTableView!.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            make.top.equalTo(month!.snp.bottom)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(HomeViewController.addEventAction))
        
        mainEventViewController = MainEventViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setToolbarHidden(true, animated: false)
        
        self.addButton?.isEnabled = false
        
        AppDelegate.trackInit(value: "HomeViewController")
        
        self.view.layoutSubviews()
        self.month?.dataMonth(calendarModel: calendarModel!, forMonth: selectedMonth!, delegate: self)
        
        if self.selectedDate == nil && (self.calendarModel?.today(month: self.selectedMonth! + 1))! {
            self.selectedDate = Date()
        }
        
        self.eventTableView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        loadEvents(forDate: self.selectedDate)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.trackExit(value: "HomeVIewController")
        
        self.selectedDate = nil
        
        self.month?.removeAllMonth()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
    
    func loadEvents(forDate: Date?) {
        
        if forDate == nil {
            self.events?.removeAll()
        }else {
            let firstDate = CalendarUtil.firstHourOfCurrentDate(forDate: forDate!)
            let lastDate = CalendarUtil.lastHourOfCurrentDate(forDate: forDate!)
            
            self.events = EventManager.sharedInstance.eventsForDate(firstDate: firstDate as NSDate, lastDate: lastDate as NSDate)
        }
        
        DispatchQueue.main.async(execute: {
            self.eventTableView?.reloadData()
        })

    }
   
    
    func didSelectDate(day: Int, month: Int, year: Int) {
        
        self.addButton?.isEnabled = true
        
        let date = CalendarUtil.dateFromComponents(day: day, month: month, year: year)
        
        self.selectedDate = date
        
        loadEvents(forDate: date)
        
        print("Selected Date: \(day)/\(month)/\(year)")
        
    }
    
}

// MARK: - Action method
extension HomeViewController {
    
   @objc func addEventAction() {

        EventManager.sharedInstance.createEvent(forDate: self.selectedDate!)
        loadEvents(forDate: self.selectedDate!)
        
    }
    
}

// MARK: - Table view datasource methods
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let event = self.events?[indexPath.row] {
            EventManager.sharedInstance.currentEvent = event
            self.navigationController?.pushViewController(self.mainEventViewController!, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "EVENTS FOR SELECTED DAY"
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

