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
import UserNotifications
import Foundation
import Firebase
import FBSDKCoreKit


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {

    let appId = "5beed710-0391-11e7-966c-7fb6a327fd8e"
    
    var window: UIWindow?
    var locationManager = CLLocationManager()
    
    var tracking: TrackingClient?
    
    public static var sharedInstance : AppDelegate {
        
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
        
    }

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        _ = EventManager.sharedInstance
        
        
        if !Preferences.onboarded {
            let onboardStoryboard = UIStoryboard(name: "OnBoard", bundle: nil)
            
            let viewController = onboardStoryboard.instantiateInitialViewController()
            
            self.window?.rootViewController = viewController
            
        } else {
            
            enablePushNotification()
        }
        
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            
        }
        
        if Preferences.appToken == nil {
            
            Preferences.appToken = UUID().uuidString
        }
        
        tracking = TrackingClient(appId:self.appId, appToken:Preferences.appToken!)
        
        
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,  let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String  {
            Preferences.version = "\(version) (\(build))"
        }

        FirebaseApp.configure()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    
        return handled;
        
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
        
        tracking?.location = locations[0]
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
}

//MARK: - Misc Method
extension AppDelegate {
   
    func enablePushNotification() {
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                // Enable or disable features based on authorization.
            }
        }
        else {
            
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
    }
    
    
    class func trackInit(value: String) {
        AppDelegate.sharedInstance.tracking?.trackInitEvent(value: TrackEventValue.ViewAppear.rawValue + ":" + value)
    }
    
    class func trackExit(value: String) {
        AppDelegate.sharedInstance.tracking?.trackExitEvent(value: TrackEventValue.ViewDisappear.rawValue + ":" + value)
    }
    
}

//MARK: - Push Notification
extension AppDelegate {
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        Preferences.deviceToken = deviceTokenString
        
        print("Device Token:", deviceTokenString)
        
        
        let registration = DeviceRegistration(serverURL: NSURL(string: "https://push-argsoftsolutions.rhcloud.com/ag-push/")! as URL)
        
        registration.register(clientInfo: { (clientInfo: ClientDeviceInformation!)  in
            
            // apply the token, to identify this device
            clientInfo.deviceToken = deviceToken
            
            clientInfo.variantID = "7c580461-50ab-4ad2-8f1e-148be7f8456b"
            clientInfo.variantSecret = "6582f0a3-a0cc-43fe-a435-836ce2a663de"
            clientInfo.alias = Preferences.appToken
            
            // --optional config--
            // set some 'useful' hardware information params
            let currentDevice = UIDevice()
            clientInfo.operatingSystem = currentDevice.systemName
            clientInfo.osVersion = currentDevice.systemVersion
            clientInfo.deviceType = currentDevice.model
            
            }, success: {
                print("UPS registration worked");
                
            }, failure: { (error:NSError!) -> () in
                print("UPS registration Error: \(error.localizedDescription)")
        })
        
    }
    
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != .none {
            application.registerForRemoteNotifications()
        }

    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        print("Notification received")
        
    }
    
    @objc func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Failed to register:", error)
    }
    
    @objc(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:) @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.userInfo)
    }
    
    @objc(userNotificationCenter:willPresentNotification:withCompletionHandler:) @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification.request.content.userInfo)
    }
}


    
