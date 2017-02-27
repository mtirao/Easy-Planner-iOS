//
//  CustomButton.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 2/27/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    
    @IBInspectable var color: CGColor? {
        
        didSet(newValue) {
            backgroundColor = UIColor(cgColor: newValue!)
        }
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
