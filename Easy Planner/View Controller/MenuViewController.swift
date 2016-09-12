//
//  MenuViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/3/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit


class MenuViewController: UITableViewController {

    var add : UIBarButtonItem
    var flexible : UIBarButtonItem
    
    required init?(coder aDecoder: NSCoder) {
        
        add = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(MenuViewController.addNewMenuAction))
        flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        super.init(coder: aDecoder)
       
        add.target = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.toolbar.setItems([flexible, add], animated: true)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}



//MARK: - Menu view controller action methods
extension MenuViewController {
    
    func addNewMenuAction() {
        
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() {
            self.present(viewController, animated: true, completion: nil)
        }
        
    }
    
    
}
