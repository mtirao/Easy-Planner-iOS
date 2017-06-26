//
//  ActivityIndicator.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 4/3/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class ActivityIndicator: UIViewController{

    @IBOutlet weak var label:UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var background: UIView!
    
    
    override func viewDidLoad() {
        self.background.layer.cornerRadius = 15
        
        NotificationController.notificationObserver(observer: self, selector: #selector(ActivityIndicator.setLabel), name: Notes.activityIndicatorNotification.notification)
    
    }
    
    func startAnimating() {
        self.indicator.startAnimating()
    }
    
    func stopAnimating() {
        self.indicator.stopAnimating()
    }
    
    @objc func setLabel(notification: Notification) {
        
        if let labelText = notification.userInfo?["label"] as? String{
            DispatchQueue.main.async {
                self.label.text = labelText
            }
        }
        
    }
}
