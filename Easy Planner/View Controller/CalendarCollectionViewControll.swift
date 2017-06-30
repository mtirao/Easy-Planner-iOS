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
private let cloudEventSegue = "cloudSegue"
private let newEventSegue = "newEventSegue"

class CalendarCollectionViewControll: UICollectionViewController {
    
    var calendars : [CalendarModel] = [CalendarModel]()
    
    let homeViewController : HomeViewController
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 50, height: 35)
        layout.itemSize = CGSize(width: 107, height: 105)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        
        homeViewController = HomeViewController()
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        homeViewController = HomeViewController()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...11 {
                calendars.append(CalendarModel(addYear: i))
        }
        
        self.navigationController?.navigationBar.tintColor = Theme.barTint
        
        self.collectionView?.register(CalendarCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(CalendarHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerSection)
        self.collectionView?.backgroundColor = UIColor.white
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Event", style: .plain, target: self, action: #selector(CalendarCollectionViewControll.newEventAction))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Action Method
    
    @objc func newEventAction() {
        
        let date = Date()
        EventManager.sharedInstance.createEvent(forDate: date)
        
        let backItem = UIBarButtonItem()
        backItem.title = CalendarUtil.string(from: date, timeOnly: false)
        self.navigationItem.backBarButtonItem = backItem
    }
    
    
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
        } else if segue.identifier == cloudEventSegue {
            if let cloudEvent = segue.destination as? CloudEventViewController {
                cloudEvent.yearly = true
                cloudEvent.selectedDate = Date()
            }
        } else if segue.identifier == newEventSegue {
            let date = Date()
            EventManager.sharedInstance.createEvent(forDate: date)
            
            let backItem = UIBarButtonItem()
            backItem.title = CalendarUtil.string(from: date, timeOnly: false)
            self.navigationItem.backBarButtonItem = backItem

            
        }
        
    }
    
    // MARK: UICollectionViewDataSource & Delegate

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
            if indexPath.section == 0 {
                header.yearLabel.textColor = Theme.barTint
            } else {
                header.yearLabel.textColor = UIColor.black
            }
            header.yearLabel.text = calendars[indexPath.section].yearAsString()
        }
        
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = calendars[indexPath.section]
        
        model.longMonthName = true;
        homeViewController.calendarModel = model
        homeViewController.selectedMonth = indexPath.row
        
        self.navigationController?.pushViewController(self.homeViewController, animated: true)
        
        let backItem = UIBarButtonItem()
        backItem.title = "\(model.monthName(month: indexPath.row )) \(model.year)"
        self.navigationItem.backBarButtonItem = backItem
        
        model.longMonthName = false
        
    }
    
}
