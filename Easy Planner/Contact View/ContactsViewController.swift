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

fileprivate let contactCell = "contactCell"

fileprivate let contactDetailSegue = "contactDetailSegue"
fileprivate let addContactSegue = "addContactSegue"

class ContactsViewController: UITableViewController, CNContactPickerDelegate {

    var contacts :[Contact]?
    var toolbarItem = [UIBarButtonItem]()
    
    var newContactViewController : NewContactViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: contactCell)
        
        toolbarItem.append(UIBarButtonItem(title: "Address Book", style: .plain , target: self, action: #selector(ContactsViewController.addressBookAction) ))
        toolbarItem.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil ))
        toolbarItem.append(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ContactsViewController.addContactAction)))
        
        newContactViewController = NewContactViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppDelegate.trackInit(value: "ContactsViewController")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = "Event's contact"
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        self.navigationController?.toolbar.tintColor = Theme.barTint
        self.navigationController?.toolbar.setItems(toolbarItem, animated: true)
        
        if let event = EventManager.sharedInstance.currentEvent {
            self.contacts = EventManager.sharedInstance.contactsForEvent(event: event)
            self.tableView?.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.trackExit(value: "ContactsVIewController")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


//MARK: - Contacts view controller action methods
extension ContactsViewController {
    
    @objc func addressBookAction() {
        
        let addressBookController = CNContactPickerViewController()
        addressBookController.delegate = self
        
        
        self.present(addressBookController, animated: true, completion: nil)
        
    }
    
    @objc func addContactAction() {
        
        if let event = EventManager.sharedInstance.currentEvent {
            let contact = EventManager.sharedInstance.addContactToEvent(event: event)
            self.contacts?.append(contact)
            self.tableView?.reloadData()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newContactViewController = self.newContactViewController else {
            return
        }
        
        let selectedContact = self.contacts?[indexPath.row]
        newContactViewController.currentContact = selectedContact
        self.navigationController?.pushViewController(newContactViewController, animated: true)
    }
    
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

