//
//  MainEventViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/31/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

let contactViewControllerIdentifier = "contactsViewController"

class MainEventViewController: UIViewController {
    
    var contactViewController: ContactsViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Contacts", style: .plain, target: self, action: #selector(MainEventViewController.contactAction))
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

//MARK: - Action Methods
extension MainEventViewController {
    
    func contactAction() {
        
        if contactViewController == nil {
            self.contactViewController = self.storyboard?.instantiateViewController(withIdentifier: contactViewControllerIdentifier) as? ContactsViewController
        }
        
        if let contact = self.contactViewController {
            self.navigationController?.pushViewController(contact, animated: true)
        }
    }
    
}
