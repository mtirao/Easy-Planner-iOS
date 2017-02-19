//
//  NewContactViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/5/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit



class NewContactViewController: UIViewController {

    var currentContact : Contact?
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    var editting = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(editting) {
            titleLabel?.text = "Edit Contact";
        }else {
            titleLabel?.text = "New Contact";
        }
        
        self.firstName?.text = currentContact?.name
        self.email?.text = currentContact?.email
        self.phone?.text = currentContact?.phone
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
        
        currentContact?.name = self.firstName?.text;
        currentContact?.email = self.email?.text;
        currentContact?.phone = self.phone?.text;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

//MARK: - Action Methods
extension NewContactViewController {
    
    
    @IBAction func doneAction(_ sendder: AnyObject) {
        self.dismiss(animated: true, completion: nil);
        
    }
    
}
