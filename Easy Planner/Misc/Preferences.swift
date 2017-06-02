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
private let userTokenKey = "userToken"
private let appTokenKey = "appToken"
private let deviceTokenKey = "deviceToken"
private let requireConfKey = "requireConfirmation"
private let sendNotifKey = "sendNotificationKey"
private let allowMakeSuggesKey = "allowMakeSuggestion"
private let versionKey = "versionKey"
private let pushNotificationKey = "pushNotification"
private let userNameKey = "userNameKey"
private let passwordKey = "passwordKey"
private let onboardedKey = "onboarded"

class Preferences {
    
    
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
            if (newValue != nil) {
                UserDefaults.standard.set(newValue, forKey: latitudeKey)
            }
        }
        
        get {
            return UserDefaults.standard.double(forKey: latitudeKey)
        }
    }
    
    static var deviceToken: String {
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: deviceTokenKey)
        }
        
        get {
            return UserDefaults.standard.string(forKey: deviceTokenKey) ?? ""
        }
    }
    
    static var appToken: String? {
        
        set {
            if (newValue != nil) {
                UserDefaults.standard.set(newValue, forKey: appTokenKey)
            }
        }
        
        get {
            return UserDefaults.standard.string(forKey: appTokenKey)
        }
    }
    
    static var requireConfirmation: Bool {
        
        set {
            UserDefaults.standard.set(newValue, forKey: requireConfKey)
        }
        
        get {
            return UserDefaults.standard.bool(forKey: requireConfKey)
        }
    }
    
    static var sendNotification: Bool {
        
        set {
            UserDefaults.standard.set(newValue, forKey: sendNotifKey)
        }
        
        get {
            return UserDefaults.standard.bool(forKey: sendNotifKey)
        }
    }
    
    static var allowMakeSuggestion: Bool {
        
        set {
            UserDefaults.standard.set(newValue, forKey: allowMakeSuggesKey)
        }
        
        get {
            return UserDefaults.standard.bool(forKey: allowMakeSuggesKey)
        }
    }
    
    static var pushNotification: Bool {
        
        set {
            UserDefaults.standard.set(newValue, forKey: pushNotificationKey)
        }
        
        get {
            return UserDefaults.standard.bool(forKey: pushNotificationKey)
        }
    }
    
    static var version: String {
        set {
            UserDefaults.standard.set(newValue, forKey: versionKey)
        }
        
        get {
            return UserDefaults.standard.string(forKey: versionKey) ?? "1.0 (1)"
        }

    }
    
    static var userName: String {
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: userNameKey)
        }
        
        get {
            return UserDefaults.standard.string(forKey: userNameKey) ?? ""
        }
    }
    
    static var password: String {
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: passwordKey)
        }
        
        get {
            return UserDefaults.standard.string(forKey: passwordKey) ?? ""
        }
    }
    
    static var userToken: String? {
        
        set {
            
            UserDefaults.standard.set(newValue, forKey: userTokenKey)
        }
        
        get {
            return UserDefaults.standard.string(forKey: userTokenKey) ?? ""
        }
    }
    
    static var onboarded: Bool {
        
        set {
            UserDefaults.standard.set(newValue, forKey: onboardedKey)
        }
        
        get {
            return UserDefaults.standard.bool(forKey: onboardedKey)
        }
        
    }
    
}
