//
//  Calendar.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/28/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

class Calendar: UIView {
    
    let dayOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    let header : CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func draw(_ rect: CGRect) {
        
        drawDayOfWeek(rect)
        
    }
    

}


extension Calendar {
    
    func drawDayOfWeek(_ frame: CGRect ) {
        
        let step = frame.size.width / 7
        
        let attrs = [NSFontAttributeName : UIFont.systemFont(ofSize: 12)]
        
        for i in 0...6 {
            
            let dayName : NSString = dayOfWeek[i]
            
            let size = dayName.size(attributes: attrs)
            
            let pos = CGPoint(x: frame.origin.x + (step / 2) - (size.width / 2)  + (CGFloat(i) * step), y: header )
            
            dayName.draw(at: pos, withAttributes: attrs)
            
        }
        
    }
    
}
