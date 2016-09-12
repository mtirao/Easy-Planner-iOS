//
//  Preferences.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/9/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

private let longitudeKey = "longitude"
private let installedKey = "installed"
private let latitudeKey = "latitud"

class Preferences: NSObject {
    
    
    static var installed : Bool {
        set {
            if (newValue) {
                UserDefaults.standard.set(newValue, forKey: installedKey)
            }
        }
        
        get {
            return UserDefaults.standard.bool(forKey: installedKey)
        }
    }

    static var longitude : Double? {
        
        set {
            if ((newValue) != nil) {
                UserDefaults.standard.set(newValue, forKey: longitudeKey)
            }
        }
        
        get {
            return UserDefaults.standard.double(forKey: longitudeKey)
        }
    }
    
    static var latitude : Double? {
        
        set {
            if ((newValue) != nil) {
                UserDefaults.standard.set(newValue, forKey: latitudeKey)
            }
        }
        
        get {
            return UserDefaults.standard.double(forKey: latitudeKey)
        }
    }
    
}
