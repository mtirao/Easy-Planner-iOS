//
//  RegistrationOnboardViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 6/3/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

class RegistrationOnboardViewController: UIViewController {
    
    let loginButtonWidth : Int = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        
        loginButton.frame = CGRect(x: Int(view.center.x) - loginButtonWidth / 2, y: Int(view.center.y), width: loginButtonWidth, height: 40)
        //loginButton.center = view.center
        
        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueAction(sender: Any?) {
        
        NotificationController.postNotification(name: Notes.endOnboardNotification.notification, userInfo: nil)
        
    }
    
    

}
