//
//  NewContactViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/5/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

fileprivate let nameSegue = "nameSegue"
fileprivate let phoneSegue = "phoneSegue"
fileprivate let emailSegue = "emailSegue"

class NewContactViewController: UIViewController {

    var currentContact : Contact?
    var editting = false;
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    
    var nameField : FieldViewController?
    var phoneField : FieldViewController?
    var emailField: FieldViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "";
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(editting) {
            self.navigationItem.title = "Edit Contact";
        }else {
            self.navigationItem.title = "New Contact";
        }
        
        
        self.nameField?.editText.text = currentContact?.name
        self.emailField?.editText.text = currentContact?.email
        self.phoneField?.editText.text = currentContact?.phone
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain
            , target: nil, action: nil)
        
        //self.navigationController?.navigationItems.backBarButtonItem?.title = "";
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
        
        currentContact?.name = self.nameField?.editText.text;
        currentContact?.email = self.emailField?.editText.text;
        currentContact?.phone = self.phoneField?.editText.text;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == nameSegue {
            self.nameField = segue.destination as? FieldViewController
        }else if segue.identifier == phoneSegue {
            self.phoneField = segue.destination as? FieldViewController
        }else if segue.identifier == emailSegue {
            self.emailField = segue.destination as? FieldViewController
        }
        
    }
    
}

//MARK: - Action Methods
extension NewContactViewController {
    
    
    @IBAction func doneAction(_ sendder: AnyObject) {
        self.dismiss(animated: true, completion: nil);
        
    }
    
}
