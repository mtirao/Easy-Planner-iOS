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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueAction(sender: Any?) {
        
        NotificationController.postNotification(name: Notes.endOnboardNotification.notification, userInfo: nil)
        
    }
    
    @IBAction func facebookLoginBtnAction(_ sender: Any) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        if((FBSDKAccessToken.current()) != nil){
                            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                                if (error == nil){
                                    //self.dict = result as! [String : AnyObject]
                                    print(result!)
                                    //print(self.dict)
                                }
                            })
                        }
                    }
                }
            }
        }
    }

}
