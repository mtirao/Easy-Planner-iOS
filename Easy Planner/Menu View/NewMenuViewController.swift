//
//  NewMenuViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/6/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let menuDescriptionCell = "menuDescriptionCell"
fileprivate let menuDetailNameSegue = "menuDetailNameSegue"
fileprivate let menuPriceSegue = "menuPriceSegue"
fileprivate let menuNameSegue = "menuNameSegue"
fileprivate let menuDetailDescriptionSegue = "menuDetailDescriptionSegue"
fileprivate let showDetailSegue = "showDetailSegue"

fileprivate let menuDetailTag = 2

class NewMenuViewController: UIViewController {
    
    private let logoSize : Int = 120
    private let top : Int = 72
    
    var logo : UIImageView?
    
    var fields : [FieldView] = [FieldView]()
    
    var currentMenu : Menu?
    
    /*var menuDetail : [Option]?
    
    var editting = false;
    
    var menuPrice : FieldViewController?
    var menuName : FieldViewController?
    var menuDetailName : FieldViewController?
    var menuDetailDescription : FieldViewController?
    
    @IBOutlet weak var detailTable: UITableView!
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewMenuViewController.keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(NewMenuViewController.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        self.view.backgroundColor = UIColor.white
        
        let image = UIImage(named: "menu")
        logo = UIImageView(image: image)
        
        self.view.addSubview(logo!)
        logo?.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(logoSize)
            make.centerX.equalTo(self.view)
            make.top.equalTo(top)
        }
        
        let nameField = FieldView(frame: CGRect.zero, type: .text, label: "Name:")
        nameField.placeHolder = "Give this menu a name"
        self.view.addSubview(nameField)
        nameField.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(45)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.equalTo((logo?.snp.bottom)!).offset(8)
        }
        
        let priceField = FieldView(frame: CGRect.zero, type: .currency, label: "Price:")
        priceField.placeHolder = "Enter price for this menu"
        priceField.deleteWhenStartEditting = true
        self.view.addSubview(priceField)
        priceField.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(45)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.equalTo(nameField.snp.bottom).offset(8)
        }
        
        fields.append(nameField)
        fields.append(priceField)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(NewMenuViewController.presentDetailMenu))
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let nameField = self.fields[0]
        nameField.data = currentMenu?.menuname
        
        let priceField = self.fields[1]
        priceField.data = currentMenu?.price?.stringValue
         
        AppDelegate.trackInit(value: "NewMenuViewController")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let nameField = self.fields[0]
        currentMenu?.menuname = nameField.data
        
        let priceField = self.fields[1]
        currentMenu?.price = NSDecimalNumber(string: priceField.data)
        
        EventManager.sharedInstance.saveContext()
        
        AppDelegate.trackExit(value: "NewMenuViewController")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
 
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        
    }
    
    @objc func presentDetailMenu() {
        
    }
    
}

//Action method
extension NewMenuViewController {
    
    @IBAction func close(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
        
}


