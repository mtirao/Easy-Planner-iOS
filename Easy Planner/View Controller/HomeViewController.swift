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


class HomeViewController: UIViewController, CalendarControllerDelegate {
    
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var calendarController : CalendarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == embededCalendarSegue {
            
            self.calendarController = segue.destination as? CalendarController
            self.calendarController?.delegate = self
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == addEventSegue {
            return calendarController?.selectedDate != nil
        }
        
        return true
        
    }
    
    func daySelectionChange(selected: Bool) {
        self.addButton.isEnabled = selected
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
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: homeEventCell)
        
        return cell!
        
    }
    
    
}
