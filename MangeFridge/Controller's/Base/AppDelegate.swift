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
    var wsManager = WebserviceManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        //Get Ingredients and filters
        self.getIngredients()
        self.getFilters()
       //Set navigation bar color
        UINavigationBar.appearance().barTintColor = UIColor(red: 134/255, green: 198/255, blue: 86/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        //Change Status Bar Color
        UIApplication.shared.statusBarStyle = .lightContent
        //Autologin
        if UserDefaults.standard.value(forKey: "user") != nil{
            let dict = UserDefaults.standard.object(forKey: "user")
            Singleton.sharedInstance.user = getUser(dict as! [String : AnyObject])
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Menu", bundle: nil)
            let exampleViewController: HostViewController = mainStoryboard.instantiateViewController(withIdentifier: "ID_HostViewController") as! HostViewController
            let navigationController = UINavigationController(rootViewController: exampleViewController);
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
        return true
    }
    //Get Ingredients
    func getIngredients(){
        wsManager.getIngredients { (sucess, ingredients) in
            if sucess{
                //save ingredients to singleton for further use
                Singleton.sharedInstance.ingredients = ingredients
            }
        }
        
    }
    //Get Filters
    func getFilters(){
        wsManager.getFilters { (sucess, filters) in
            if sucess{
                //save filters to singleton for further use
                Singleton.sharedInstance.filters = filters
            }
        }
    }
    //Save data form user dict to user model
    fileprivate func getUser(_ dict: [String: AnyObject])  -> User {
        let user = User(id:  dict["id"] as? String ?? "", name: dict["name"] as? String ?? "", email: dict["email"] as? String ?? "", userImageUrlString: dict["image"] as? String ?? "")
        return user
    }
    
}

