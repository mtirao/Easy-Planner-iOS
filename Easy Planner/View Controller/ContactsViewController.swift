//
//  ContactsViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/3/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

let menuViewControllerIdentifier = "menuViewControllerIdentifier"

class ContactsViewController: UIViewController {

    var menuViewController: MenuViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(ContactsViewController.menuAction))
        
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}


//MARK: - Contacts view controller action methods
extension ContactsViewController {
    
    func menuAction() {
        
        if menuViewController == nil {
            self.menuViewController = self.storyboard?.instantiateViewController(withIdentifier: menuViewControllerIdentifier) as? MenuViewController
        }
        
        if let contact = self.menuViewController {
            self.navigationController?.pushViewController(contact, animated: true)
        }
    }

    
}
