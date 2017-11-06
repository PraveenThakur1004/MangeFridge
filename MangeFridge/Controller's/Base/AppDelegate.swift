//
//  AppDelegate.swift
//  MangeFridge
//
//  Created by MAC on 03/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Change Status Bar Color
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }

}

