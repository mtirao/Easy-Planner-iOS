//
//  RegistrationOnboardViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 6/3/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class RegistrationOnboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueAction(sender: Any?) {
        
        NotificationController.postNotification(name: Notes.endOnboardNotification.notification, userInfo: nil)
        
    }

}
