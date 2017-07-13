//
//  Alert.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 7/11/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class Alert {
    
    func showAlert(title:String, message: String) {
        
        let alert = UIAlertController(title: title, message: title, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        alert.present(alert, animated: true, completion: nil)
    }
    
}
