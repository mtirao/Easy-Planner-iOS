//
//  ActivityIndicator.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 4/3/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class ActivityIndicator: UIView{

    let label:UILabel = UILabel()
    let indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        indicator.color = Theme.barTint
        self.addSubview(indicator)
        indicator.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(8)
            make.width.height.equalTo(70)
            make.center.equalTo(self)
        }
        
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        self.addSubview(label)
        label.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(25)
            make.centerX.equalTo(self)
            make.top.equalTo(indicator.snp.bottom)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func startAnimating() {
        self.indicator.startAnimating()
    }
    
    func stopAnimating() {
        self.indicator.stopAnimating()
    }
    
    
}
