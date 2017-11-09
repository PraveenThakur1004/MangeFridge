//
//  AppDelegate.swift
//  MangeFridge
//
//  Created by MAC on 03/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import UserNotifications
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
         IQKeyboardManager.sharedManager().enable = true
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor(red: 134/255, green: 198/255, blue: 86/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        //Change Status Bar Color
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }

}

