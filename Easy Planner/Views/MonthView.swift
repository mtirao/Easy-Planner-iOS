//
//  MonthView.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 5/19/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class MonthView: UIView {

    var delegate: CalendarViewDelegate?
    
    var month : Int?
    var year : Int?
    
    let spacing : Int = 4
    let halfSpacing : Int = 2
    
    let numColums = 7
    let numRows = 6
    
    let header : Int = 12
    
    let dayNames = ["SUN", "MON", "TUE", "WED", "THU", "SAT", "SAT"]
    
    @IBInspectable var fontSize: CGFloat = 9
    @IBInspectable var headerTopSpacing: CGFloat = 0
    @IBInspectable var headerLeftSpacing: CGFloat = 0
    @IBInspectable var monthTopSpacing: CGFloat = 0
    @IBInspectable var longMonthName: Bool = false
    @IBInspectable var dayName: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MonthView.didSelectMonth))
        self.addGestureRecognizer(tapGesture)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func didSelectMonth() {
        print("Hello")
        
        self.delegate?.didSelectMonth(month: month!, year: year!)
    }
    
    
    func dataMonth(calendarModel: CalendarModel, forMonth: Int, delegate: CalendarViewDelegate?=nil) {
        
        if !dayName {
            calendarModel.longMonthName = self.longMonthName
            let name = UILabel(frame: CGRect(x: Int(headerLeftSpacing), y: Int(headerTopSpacing), width: Int(self.frame.width), height: header))
            name.text = calendarModel.monthName(month: forMonth)
            name.textColor = Theme.barTint
            self.addSubview(name)
        }
        
        self.delegate = delegate
        self.month = forMonth
        self.year = calendarModel.year
        
        let dayHStep = Int(self.frame.width) / 7
        let dayVStep = (Int(self.frame.height) - header - halfSpacing) / 6
        
        let calendar = calendarModel.calendarForMonth(month: forMonth + 1)
        
        var headerSpacing = header + Int(self.headerTopSpacing) + Int(monthTopSpacing)
        
        if calendar[5][0] == 0 {
            headerSpacing = header + Int(self.headerTopSpacing) + Int(monthTopSpacing) + 8
        }
        
        if dayName {
            for i in 0..<numColums {
                let day = UILabel(frame: CGRect(x: halfSpacing + i * dayHStep, y: Int(headerTopSpacing) + header, width: dayHStep - halfSpacing, height: header))
                day.text = self.dayNames[i]
                day.font = UIFont.systemFont(ofSize: fontSize)
                day.textColor = Theme.barTint
                day.textAlignment = .center
                self.addSubview(day)
            }
        }
        
        for row in 0..<numRows {
            for col in 0..<numColums {
                
                if calendar[row][col] != 0 {
                    let label = UILabel(frame: CGRect(x: halfSpacing + col * dayHStep, y: row * dayVStep + headerSpacing + halfSpacing, width: dayHStep - halfSpacing, height: dayVStep - halfSpacing))
                    label.font = UIFont.systemFont(ofSize: fontSize)
                    label.text = String(calendar[row][col])
                    label.textAlignment = .center
                    self.addSubview(label)
                    
                }
            }
        }

    }
}
