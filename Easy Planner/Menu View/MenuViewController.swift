//
//  MenuViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/3/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

fileprivate let menuDetailSegue = "menuSegue"
fileprivate let menuCell = "menuCell"

class MenuViewController: UITableViewController {

    var currentMenu : Menu?
    
    var menus :[Menu]?
    
    var newMenuViewController : NewMenuViewController?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MenuViewController.addNewMenuAction))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: menuCell)
        
        newMenuViewController = NewMenuViewController()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let event = EventManager.sharedInstance.currentEvent {
            self.menus = EventManager.sharedInstance.menuForEvent(event: event)
            self.tableView?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Event's Menu";
        
        AppDelegate.trackInit(value: "MenuViewController")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.trackExit(value: "MenuVIewController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*if segue.identifier == menuDetailSegue {
            
            if let menuDetail = segue.destination as? NewMenuViewController{
                
                if let selectedCell = self.tableView.indexPathForSelectedRow{
                    menuDetail.editting = true
                    menuDetail.currentMenu = self.menus?[selectedCell.row]
                }else {
                    menuDetail.editting = false;
                    menuDetail.currentMenu = self.currentMenu
                }
                
            }
            
        }*/
        
        
    }
    
}


//MARK: - Menu view controller action methods
extension MenuViewController {
    
    @objc func addNewMenuAction() {
        
        if let event = EventManager.sharedInstance.currentEvent {
        
            currentMenu = EventManager.sharedInstance.addMenuToEvent(event: event)
            self.menus = EventManager.sharedInstance.menuForEvent(event: event)
            self.tableView?.reloadData()
        }
    
    }
    
}


//MARK: - Table View Delegate and DataSource
extension MenuViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuViewController = self.newMenuViewController else {
            return
        }
        
        self.currentMenu = self.menus?[indexPath.row]
        menuViewController.currentMenu = self.currentMenu
        self.navigationController?.pushViewController(menuViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            if let menu = self.menus?[indexPath.row], let event = EventManager.sharedInstance.currentEvent {
                EventManager.sharedInstance.removeMenuFromEvent(event: event, menu: menu)
                self.menus?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        default: break
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return self.menus?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: menuCell)
        
        if let menu = self.menus?[indexPath.row] {
            
            cell?.textLabel?.text = menu.menuname
            
        }
        
        return cell!
        
    }
    
    
}
