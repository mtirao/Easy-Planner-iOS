//
//  CalendarCell.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 5/24/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var calendar: MonthView!
    
    
    override func prepareForReuse() {
        
        for view in self.calendar.subviews {
            
            if view is UILabel {
                view.removeFromSuperview()
            }
        }
    }
    
}
