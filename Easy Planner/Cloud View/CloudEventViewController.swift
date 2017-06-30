//
//  CloudEventViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 3/22/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

private let cellReuseIndentifier = "cloudEventCell"
private let cloudDetail = "cloudDetail"

class CloudEventViewController: UITableViewController {

    var selectedDate: Date?
    var yearly: Bool = false;
    
    let cloudViewModel : CloudEventViewModel
    
    
    required init?(coder: NSCoder) {
        cloudViewModel = CloudEventViewModel()
        
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let date = selectedDate {
            cloudViewModel.fetchEventsForMonth(month: date, yearly: yearly)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension CloudEventViewController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cloudViewModel.count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIndentifier, for: indexPath)
        
        if let event = cloudViewModel.eventDetail(atIndexPath: indexPath) {
            cell.textLabel?.text = event.0
            cell.detailTextLabel?.text = event.1

        }

        return cell
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == cloudDetail {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destination = segue.destination as! CloudEventDetailViewController
                self.cloudViewModel.selectCurrent(atIndexPath: indexPath)
                destination.cloudViewModel = self.cloudViewModel
            }
        }
    }


}
