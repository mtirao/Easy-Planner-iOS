//
//  PushOnboardViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 6/1/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class PushOnboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func enablePushNotification(_ sender: Any) {
        
        AppDelegate.sharedInstance.enablePushNotification()
        
    }


}
