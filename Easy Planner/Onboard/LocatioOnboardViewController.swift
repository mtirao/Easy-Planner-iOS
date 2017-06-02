//
//  LocatioOnboardViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 6/1/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreLocation

class LocatioOnboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func enableLocation(_ sender: Any) {
        
        if CLLocationManager.authorizationStatus() == .notDetermined{
            AppDelegate.sharedInstance.locationManager.requestWhenInUseAuthorization()
            
        }
        
    }
    
    
    
}
