//
//  Day.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/28/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

class Day: UIView {

    var number: Int = 0
    
    var delegate: CalendarDelegate?
    
    var selected: Bool = false
    var today: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Day.didSelectDay))
        tapGesture.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let halfWidth = rect.size.width / 2
        let halfHeight = rect.size.height / 2
        
        var attrs : [String : AnyObject] = [NSFontAttributeName : UIFont.systemFont(ofSize: 15)]
        
        let num : NSString = "\(number)"
        let size = num.size(attributes: attrs)

        let rectSize = sqrt(size.width * size.width + size.height * size.height)
        
        let rectPos = CGRect(x: halfWidth - rectSize / 2, y: halfHeight - rectSize / 2, width: rectSize, height: rectSize )
        let path = UIBezierPath(ovalIn: rectPos)
        
        if selected {
            
            UIColor.black.setFill()
            
            path.fill()
            
            attrs = [NSFontAttributeName : UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName : UIColor.white]
        }else if today {
            
            Theme.todayColor.setFill()
            
            path.fill()
            
            attrs = [NSFontAttributeName : UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName : UIColor.white]
        }
        
        
        
        let pos = CGPoint(x: halfWidth - size.width / 2, y: halfHeight - size.height / 2 )
        
        if number != 0 {
            num.draw(at: pos, withAttributes: attrs)
        }
        
        
    }
    
    func didSelectDay(sender: AnyObject) {
        
        if let del = delegate {
            del.didSelectDay(day: self)
        }
        
    }
    
}
