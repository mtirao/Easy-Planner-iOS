//
//  CalendarDelegate.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/29/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

protocol CalendarControllerDelegate {
    
    func daySelectionChange(selected: Bool)
    func adjustHeight(height: Int)
    
}

protocol CalendarViewDelegate {
    
    func didSelectMonth(month: Int, year: Int)
    
}
