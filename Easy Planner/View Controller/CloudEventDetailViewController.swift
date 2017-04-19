//
//  CloudEventDetailViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 3/31/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class CloudEventDetailViewController: UITableViewController, UINavigationBarDelegate {

    
    private let statusNavigationBarHeight : CGFloat = 64
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    var name : String = ""
    var date : String = ""
    var activityIndicator: ActivityIndicator?
    
    weak var cloudViewModel : CloudEventViewModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationStyle = .overFullScreen
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(CloudEventDetailViewController.saveAction))
        
        self.navigationItem.rightBarButtonItem = saveButton
        
        activityIndicator = self.storyboard?.instantiateViewController(withIdentifier: "activityIndicator") as? ActivityIndicator
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if let detail = cloudViewModel?.eventDetail() {
            self.eventName.text = detail.0
            self.eventDate.text = detail.1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func saveAction() {
        
        
        if let indicator = activityIndicator {
            
            let navController = UINavigationController(rootViewController: indicator)
            navController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController?.present(navController, animated: false, completion:  { [weak activityIndicator = self.activityIndicator] in
                
                activityIndicator?.startAnimating()
                
                NotificationController.postNotification(name: Notes.activityIndicatorNotification.notification, userInfo: ["label" as NSObject : "Saving..." as AnyObject])
                
                self.cloudViewModel?.saveToCloud()
            })
            
        }
    
    }

}
