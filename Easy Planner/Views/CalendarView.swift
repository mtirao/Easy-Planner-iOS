//
//  CalendarView.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 5/18/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    
    let spacing = 8
    let halfSpacing = 4
    
    let numColums = 7
    let numRows = 6

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func calendar(calendar: [[Int]], forMonth: Int) {
        
        var i = forMonth / 3
        var j = forMonth % 3
        
        let HStep = Int(self.frame.size.width) / 3
        let VStep = Int(self.frame.size.height) / 4
        
        let month = UIView(frame: CGRect(x: halfSpacing + j * HStep, y: i * VStep, width: HStep - spacing, height: VStep - spacing))
        month.backgroundColor = UIColor.blue
        
        let dayHStep = Int(month.frame.width) / 7
        let dayVStep = Int(month.frame.height) / 6
        
        for i in 0..<numRows {
            for j in 0..<numColums {
                
                if calendar[i][j] != 0 {
                    let label = UILabel(frame: CGRect(x: halfSpacing + j * dayHStep, y: i * dayVStep, width: dayHStep - halfSpacing, height: dayVStep - halfSpacing))
                    label.text = String(calendar[i][j])
                    
                }
            }
        }
        
        
        self.addSubview(month)
        
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
