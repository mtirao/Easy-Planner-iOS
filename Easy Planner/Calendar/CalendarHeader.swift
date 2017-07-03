//
//  CalendarHeaderCollectionReusableView.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 5/24/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class CalendarHeader: UICollectionReusableView {
 
    var yearLabel: UILabel!
    
    
    override init(frame: CGRect) {
        yearLabel = UILabel()
        yearLabel.font = UIFont.boldSystemFont(ofSize: 30)
        super.init(frame: frame)
        
        self.addSubview(yearLabel)
        yearLabel.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(self).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.bottom.equalTo(self).inset(UIEdgeInsets(top: 2, left: 0, bottom: 4, right: 0))
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        self.addSubview(line)
        line.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(1)
            make.leading.equalTo(yearLabel)
            make.trailing.equalTo(0)
            make.top.equalTo(yearLabel.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        yearLabel = UILabel()
        yearLabel.font = UIFont.boldSystemFont(ofSize: 30)
        super.init(coder: aDecoder)
        
        self.addSubview(yearLabel)
        yearLabel.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(self).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.bottom.equalTo(self).inset(UIEdgeInsets(top: 2, left: 0, bottom: 4, right: 0))
        }
    }
}
