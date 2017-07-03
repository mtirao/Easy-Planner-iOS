//
//  FieldViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/9/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit
import SnapKit


class SwitchFieldView: UIView {
    
    private let switchView = UISwitch()
    
    var isOn : Bool{
        get {
            return switchView.isOn
        }
    }
    
    init(frame: CGRect, label: String) {
        
        super.init(frame: frame)
        
        let staticText = UILabel();
        staticText.font = UIFont.boldSystemFont(ofSize: 20)
        staticText.text = label
        self.addSubview(staticText)
        staticText.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(25)
            make.leading.equalTo(self)
            make.trailing.equalTo(0)
            make.top.equalTo(0)
        }
        
        switchView.setOn(true, animated: false)
        self.addSubview(switchView)
        switchView.snp.makeConstraints{(make) -> Void in
            make.leading.equalTo(staticText)
            make.top.equalTo(staticText.snp.bottom).offset(4)
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        self.addSubview(line)
        line.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(1)
            make.leading.equalTo(staticText)
            make.trailing.equalTo(0)
            make.top.equalTo(switchView.snp.bottom).offset(4)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

