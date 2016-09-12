//
//  ContactsViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/3/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

let menuViewControllerIdentifier = "menuViewControllerIdentifier"

class ContactsViewController: UITableViewController, CNContactPickerDelegate {

    var menuViewController: MenuViewController?
    
    var addressBook : UIBarButtonItem
    var add : UIBarButtonItem
    var flexible : UIBarButtonItem
    
    required init?(coder aDecoder: NSCoder) {
        
        addressBook = UIBarButtonItem(title: "Contact", style: .plain, target: nil, action: #selector(ContactsViewController.addressBookAction))
        add = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(ContactsViewController.addNewContactAction))
        flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        super.init(coder: aDecoder)
        
        addressBook.target = self
        add.target = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(ContactsViewController.menuAction))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Event's contact"

        
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.toolbar.setItems([addressBook, flexible, add], animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}


//MARK: - Contacts view controller action methods
extension ContactsViewController {
    
    func addressBookAction() {
        
        let addressBookController = CNContactPickerViewController()
        addressBookController.delegate = self
        
        
        self.present(addressBookController, animated: true, completion: nil)
        
    }
    
    func addNewContactAction() {
        
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() {
            self.present(viewController, animated: true, completion: nil)
        }
        
    }
    
    func menuAction() {
        
        if menuViewController == nil {
            self.menuViewController = self.storyboard?.instantiateViewController(withIdentifier: menuViewControllerIdentifier) as? MenuViewController
        }
        
        if let contact = self.menuViewController {
            self.navigationController?.pushViewController(contact, animated: true)
        }
    }
    
}


extension ContactsViewController {
    
    @objc(contactPicker:didSelectContact:) func contactPicker(_ picker: CNContactPickerViewController,
                                                              didSelect contact: CNContact) {
        
        print("Hola")
    }
    
}
