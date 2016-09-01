//
//  Menu.swift
//  
//
//  Created by Marcos Tirao on 4/28/16.
//
//

import Foundation
import CoreData

@objc(Menu)
class Menu: NSManagedObject {

    func addOption(option:Option) {
        var options: NSMutableSet
        
        options = self.mutableSetValue(forKey: "option")
        options.add(option)
    }
    
    func removeOption(option:Option) {
        var options: NSMutableSet
        
        options = self.mutableSetValue(forKey: "option")
        options.remove(option)
    }

    
}
