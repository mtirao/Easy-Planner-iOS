//
//  CalendarCollectionViewControll.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 5/24/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

private let reuseIdentifier = "calendarCell"
private let headerSection = "headerSection"
private let eventSegue = "eventSegue"

class CalendarCollectionViewControll: UICollectionViewController {
    
    var calendars : [CalendarModel] = [CalendarModel]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...11 {
                calendars.append(CalendarModel(addYear: i))
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == eventSegue {
            let cell = sender as! UICollectionViewCell
            if let indexPath = self.collectionView!.indexPath(for: cell) {
            
                let model = calendars[indexPath.section]
                let destination = segue.destination as! HomeViewController
                
                model.longMonthName = true;
                destination.calendarModel = model
                destination.selectedMonth = indexPath.row
                
                let backItem = UIBarButtonItem()
                backItem.title = "\(model.monthName(month: indexPath.row )) \(model.year)"
                self.navigationItem.backBarButtonItem = backItem
                
                model.longMonthName = false
                
            }
        }
        
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 12
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 12
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let calendarCell = cell as? CalendarCell  {
            
            let model = calendars[indexPath.section]
            
            calendarCell.calendar.dataMonth(calendarModel: model, forMonth: indexPath.row)
            
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerSection, for: indexPath)
        
        if let header = headerView as? CalendarHeader {
            header.yearLabel.text = calendars[indexPath.section].yearAsString()
        }
        
        return headerView
    }
    
}
