//
//  AppDelegate.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 8/24/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager = CLLocationManager()

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        _ = EventManager.sharedInstance
        
        
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
        }else if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
            
        }

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
  
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }

   
}

//MARK: - Core Location Delegate Methods

extension AppDelegate {
    
    @objc(locationManager:didChangeAuthorizationStatus:) func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }else if CLLocationManager.authorizationStatus() == .denied{
            manager.stopUpdatingLocation()
        }

        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let latitude = locations[0].coordinate.latitude
        let longitude = locations[0].coordinate.longitude
        
        Preferences.latitude = latitude
        Preferences.longitude = longitude
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
