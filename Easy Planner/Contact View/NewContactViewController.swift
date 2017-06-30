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
    
    private let logoSize : Int = 120
    private let top : Int = 72
    
    var fields : [FieldView] = [FieldView]()
    
    var currentContact : Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewMenuViewController.keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(NewMenuViewController.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        self.view.backgroundColor = UIColor.white
        
        
        let image = UIImage(named: "contacts")
        let logo = UIImageView(image: image)
        self.view.addSubview(logo)
        logo.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(logoSize)
            make.centerX.equalTo(self.view)
            make.top.equalTo(top)
        }
        
        let nameField = FieldView(frame: CGRect.zero, type: .text, label: "Name:")
        nameField.placeHolder = "Name and Last Name"
        self.view.addSubview(nameField)
        nameField.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(45)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.equalTo(logo.snp.bottom).offset(8)
        }
        
        let phoneField = FieldView(frame: CGRect.zero, type: .text, label: "Phone:")
        phoneField.placeHolder = "Phone Number"
        phoneField.deleteWhenStartEditting = true
        self.view.addSubview(phoneField)
        phoneField.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(45)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.equalTo(nameField.snp.bottom).offset(8)
        }
        
        let emailField = FieldView(frame: CGRect.zero, type: .text, label: "Email:")
        emailField.placeHolder = "Email Address"
        emailField.deleteWhenStartEditting = true
        self.view.addSubview(emailField)
        emailField.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(45)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.equalTo(phoneField.snp.bottom).offset(8)
        }
        
        fields.append(nameField)
        fields.append(phoneField)
        fields.append(emailField)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
        let nameField = fields[0]
        let emailField = fields[2]
        let phoneField = fields[1]
        
        currentContact?.name = nameField.data
        currentContact?.email =  emailField.data
        currentContact?.phone = phoneField.data
        
        AppDelegate.trackExit(value: "NewContactViewController")
        
        EventManager.sharedInstance.saveContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nameField = fields[0]
        let emailField = fields[2]
        let phoneField = fields[1]
        
        nameField.data = currentContact?.name
        emailField.data = currentContact?.email
        phoneField.data = currentContact?.phone
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain
            , target: nil, action: nil)
        
        AppDelegate.trackInit(value: "NewContactViewController")
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        
    }
    
}

