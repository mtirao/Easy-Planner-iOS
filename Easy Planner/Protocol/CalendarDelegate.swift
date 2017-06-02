//
//  CalendarDelegate.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/29/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit


protocol CalendarViewDelegate {
    
    func didSelectDate(day: Int, month: Int, year: Int)
    
}
