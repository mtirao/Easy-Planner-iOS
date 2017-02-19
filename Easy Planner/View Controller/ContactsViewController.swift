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
let contactCell = "contactCell"

let contactDetailSegue = "contactDetailSegue"

class ContactsViewController: UITableViewController, CNContactPickerDelegate {

    var menuViewController: MenuViewController?
    
    var addressBook : UIBarButtonItem
    var add : UIBarButtonItem
    var flexible : UIBarButtonItem
    
    var contacts :[Contact]?
    
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
        
        if let event = EventManager.sharedInstance.currentEvent {
            self.contacts = EventManager.sharedInstance.contactsForEvent(event: event)
            self.tableView?.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == contactDetailSegue {
            
            if let contactDetail = segue.destination as? NewContactViewController {
                contactDetail.editting = true;
                if let selectedCell = self.tableView.indexPathForSelectedRow{
                    contactDetail.currentContact = self.contacts?[selectedCell.row]
                }
                
            }
            
        }
        
        
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
        if let viewController = storyboard.instantiateInitialViewController() as? NewContactViewController {
            viewController.editting = false;
            if let event = EventManager.sharedInstance.currentEvent {
                viewController.currentContact = EventManager.sharedInstance.addContactToEvent(event: event);
            }
            
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

//MARK: - Contact Picker Delegate
extension ContactsViewController {
    
    @objc(contactPicker:didSelectContact:) func contactPicker(_ picker: CNContactPickerViewController,
                                                              didSelect contact: CNContact) {
        
        let givenName = contact.givenName
        let middleName = contact.middleName
        let lastName = contact.familyName
        
        var phone = ""
        var email = ""
        
        if contact.phoneNumbers.count > 0 {
            phone = contact.phoneNumbers[0].value.stringValue
        }
        
        if contact.emailAddresses.count > 0 {
            email = contact.phoneNumbers[0].value.stringValue
        }
        
        
        if let event = EventManager.sharedInstance.currentEvent {
            
            let eventContact = EventManager.sharedInstance.addContactToEvent(event: event)
            eventContact.name = "\(givenName) \(middleName) \(lastName)"
            eventContact.email = "\(email)"
            eventContact.phone = "\(phone)"
            EventManager.sharedInstance.saveContext()
        }
        
        
        
    }
    
}

//MARK: - Table View Delegate and DataSource
extension ContactsViewController {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            if let contact = self.contacts?[indexPath.row], let event = EventManager.sharedInstance.currentEvent {
                EventManager.sharedInstance.removeContactFromEvent(event: event, contact: contact)
                self.contacts?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        default: break
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return self.contacts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: contactCell)
        
        if let contact = self.contacts?[indexPath.row] {
            
            cell?.textLabel?.text = contact.name
            
        }
        
        return cell!
        
    }

    
}

