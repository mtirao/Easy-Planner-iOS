//
//  CalendarCell.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 5/24/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    var calendar: MonthView
    
    override init(frame: CGRect) {
        calendar = MonthView(frame: frame)
        super.init(frame: frame)
        
        self.addSubview(calendar)
        
        calendar.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(self).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.bottom.equalTo(self).inset(UIEdgeInsets(top: 2, left: 0, bottom: 4, right: 0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        calendar = MonthView()
        super.init(coder: aDecoder)
        
        self.addSubview(calendar)
        
        calendar.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(self).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.bottom.equalTo(self).inset(UIEdgeInsets(top: 2, left: 0, bottom: 4, right: 0))
        }
    }
    
    
    override func prepareForReuse() {
        
        for view in self.calendar.subviews {
            
            if view is UILabel {
                view.removeFromSuperview()
            }
        }
    }
    
}
