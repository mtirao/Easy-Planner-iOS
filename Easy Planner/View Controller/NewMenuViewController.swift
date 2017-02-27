//
//  NewMenuViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/6/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

fileprivate let menuDescriptionCell = "menuDescriptionCell"
fileprivate let menuDetailNameSegue = "menuDetailNameSegue"
fileprivate let menuPriceSegue = "menuPriceSegue"
fileprivate let menuNameSegue = "menuNameSegue"
fileprivate let menuDetailDescriptionSegue = "menuDetailDescriptionSegue"
fileprivate let showDetailSegue = "showDetailSegue"

fileprivate let menuDetailTag = 2

class NewMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var currentMenu : Menu?
    var menuDetail : [Option]?
    
    var editting = false;
    
    var menuPrice : FieldViewController?
    var menuName : FieldViewController?
    var menuDetailName : FieldViewController?
    var menuDetailDescription : FieldViewController?
    
    @IBOutlet weak var detailTable: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(editting) {
            self.navigationItem.title = "Edit Menu";
        }else {
            self.navigationItem.title = "New Menu";
        }
        
        menuName?.editText.text = currentMenu?.menuname
        menuPrice?.editText.text = currentMenu?.price?.stringValue
        
        if self.view.tag == menuDetailTag {
            menuDetail = EventManager.sharedInstance.optionForMenu(menu: currentMenu!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == menuDetailNameSegue {
            menuDetailName = segue.destination as? FieldViewController
        }else if segue.identifier == menuPriceSegue {
            menuPrice = segue.destination as? FieldViewController
        }else if segue.identifier == menuNameSegue {
            menuName = segue.destination as? FieldViewController
        }else if segue.identifier == menuDetailDescriptionSegue {
            menuDetailDescription = segue.destination as? FieldViewController
        }else if segue.identifier == showDetailSegue {
            if let destination = segue.destination as? NewMenuViewController {
                destination.currentMenu = currentMenu
                self.currentMenu?.menuname = menuName?.editText.text
            }
        }
        
        
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


//Table Data Source and Delegete
extension NewMenuViewController {
    
    @objc(tableView:canEditRowAtIndexPath:) func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            
            break
        default: break
            
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return (self.menuDetail?.count)!;
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: menuDescriptionCell)
        
        let detail = self.menuDetail?[indexPath.row]
        
        cell?.textLabel?.text = detail?.name
        
        
        return cell!
        
    }
    
}
