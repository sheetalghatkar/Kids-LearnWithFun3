//
//  AppDelegate.swift
//  Kids-LearnWithFun
//
//  Created by sheetal shinde on 14/06/20.
//  Copyright © 2020 sheetal shinde. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var IS_Sound_ON = true
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["797e442e4f9d91d03f1f57dfc24788c9"]
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    @available(iOS 13.0, *)
    @available(iOS 13.0, *)
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

