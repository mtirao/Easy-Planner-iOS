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


class DetailMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let logoSize : Int = 120
    private let top : Int = 72
    
    var currentMenu : Menu?
    var currentOption : Option?
    var menuDetail : [Option]?
    
    var fields : [FieldView] = [FieldView]()
    
    var optionsTable = UITableView(frame: CGRect.zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewMenuViewController.keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(NewMenuViewController.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DetailMenuViewController.addNewMenuOptionAction))
        
        let image = UIImage(named: "menuDetail")
        let logo = UIImageView(image: image)
        self.view.addSubview(logo)
        logo.snp.makeConstraints { (make) -> Void in
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
            make.top.equalTo(logo.snp.bottom).offset(8)
        }
        
        let descriptionField = FieldView(frame: CGRect.zero, type: .text, label: "Description:")
        descriptionField.placeHolder = "Describe this option"
        descriptionField.deleteWhenStartEditting = true
        self.view.addSubview(descriptionField)
        descriptionField.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(45)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.equalTo(nameField.snp.bottom).offset(8)
        }
        
        fields.append(nameField)
        fields.append(descriptionField)
        
        optionsTable.register(UITableViewCell.self, forCellReuseIdentifier: menuDescriptionCell)
        optionsTable.delegate = self
        optionsTable.dataSource = self
        self.view.addSubview(optionsTable)
        optionsTable.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8))
            make.top.equalTo(descriptionField.snp.bottom).offset(8)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        if let menu = self.currentMenu {
            self.menuDetail = EventManager.sharedInstance.optionForMenu(menu: menu)
        }
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        let nameField = fields[0]
        if (nameField.data?.count)! > 0 {
            self.currentOption?.name = nameField.data
        }
        
        let descriptionField = fields[1]
        if (descriptionField.data?.count)! > 0 {
            self.currentOption?.text = descriptionField.data
        }
        
        self.optionsTable.reloadData()
        
        EventManager.sharedInstance.saveContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppDelegate.trackInit(value: "NewMenuViewController")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //currentMenu?.menuname = menuName?.editText.text
        
        AppDelegate.trackExit(value: "NewMenuViewController")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadCurrentOption() {
        
        let nameField = fields[0]
        nameField.data = currentOption?.name ?? ""
        
        let descriptionField = fields[1]
        descriptionField.data = currentOption?.text ?? ""
    }
    
    //MARK: - View Controller Actions
    @objc func addNewMenuOptionAction() {
        
        if let menu = self.currentMenu {
            
            currentOption = EventManager.sharedInstance.addOptionToMenu(menu: menu)
            
            loadCurrentOption()
            
            self.menuDetail = EventManager.sharedInstance.optionForMenu(menu: menu)
            self.optionsTable.reloadData()
            
            EventManager.sharedInstance.saveContext()
        }
        
    }
    
}

//MARK: - Table Data Source and Delegete
extension DetailMenuViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentOption = self.menuDetail?[indexPath.row]
        
        loadCurrentOption()
    }
    
    @objc(tableView:canEditRowAtIndexPath:) func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            let option = (self.menuDetail?[indexPath.row])!
            EventManager.sharedInstance.removeOptionFromEvent(menu: self.currentMenu!, option: option)
            self.menuDetail?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            break
        default: break
            
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return (self.menuDetail?.count) ?? 0;
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: menuDescriptionCell)
        
        let detail = self.menuDetail?[indexPath.row]
        
        cell?.textLabel?.text = detail?.name
        
        return cell!
        
    }
    
}
