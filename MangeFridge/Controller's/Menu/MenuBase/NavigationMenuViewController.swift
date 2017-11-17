//
// NavigationMenuViewController.swift
//
// Copyright 2017 Handsome LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit
import InteractiveSideMenu
import FTIndicator
import AlamofireImage
//import  Kingfisher
/*
 Menu controller is responsible for creating its content and showing/hiding menu using 'menuContainerViewController' property.
 */
class NavigationMenuViewController: MenuViewController {
    //MARK:- IBoutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var lbl_Name: UILabel!
     @IBOutlet weak var imageView: UIImageView!
    var wsManager = WebserviceManager()

    //MARK:-Variable and contants
    let kCellReuseIdentifier = "MenuCell"
    let menuItems = ["Search","Drinks","Food","Favourites","Top Rated","Logout"]
   let menuImages = ["search","drink","food","favorite","Top Rated","logoout"]
    
    let menuItemsGuest = ["Search","Drinks","Food","Top Rated","Login"]
    let menuImagesGuest = ["search","drink","food","Top Rated","logoout"]
    
    fileprivate var isLogout = false
//    fileprivate let wsManager = WebserviceManager()
    override var prefersStatusBarHidden: Bool {
        return false
    }
    //MARK- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Select the initial row
        if let devicetoken = Singleton.sharedInstance.deviceToken{        if devicetoken != ""{
            wsManager.updateToken(devicetoken, completionHandler: {(sucess)-> Void in
                if sucess{
                }
            })}}
        
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
        
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        if Singleton.sharedInstance.guestUser
        {
            btnProfile.isHidden = true
            lbl_Name.text = "Guest"
        }
        else{
            btnProfile.isHidden = false
            lbl_Name.text = Singleton.sharedInstance.user.name
            if let image_Str = Singleton.sharedInstance.user.userImageUrlString{
                let url = NSURL(string: image_Str)
                imageView.af_setImage(
                    withURL: url! as URL,
                    placeholderImage: nil,
                    filter: CircleFilter(),
                    imageTransition: .flipFromBottom(0.5)
                )}
        }
        
    }
    //MARK- IBAction 
    //Show Profile
    @IBAction func actionViewProfile(_ sender: UIButton) {
        guard let menuContainerViewController = self.menuContainerViewController else {
            return
        }
        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[5])
        menuContainerViewController.hideSideMenu()
    }
}
/*
 Extention of `NavigationMenuViewController` class, implements table view delegates methods.
 */
extension NavigationMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Singleton.sharedInstance.guestUser
        {
            return menuItemsGuest.count
        }
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath) as! MenuCell
        if Singleton.sharedInstance.guestUser{
            cell.imageViewMenuImage.image = UIImage(named:menuImagesGuest[indexPath.row])
            cell.lbl_MenuName.text = menuItemsGuest[indexPath.row]
        }
        else{
            cell.imageViewMenuImage.image = UIImage(named:menuImages[indexPath.row])
            cell.lbl_MenuName.text = menuItems[indexPath.row]
        }
      
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Logout From Application
        if Singleton.sharedInstance.guestUser == false{

        if    (indexPath.row == 5){
            self.logout()
        }
        else{
            guard let menuContainerViewController = self.menuContainerViewController else {
                return
            }
            menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
            menuContainerViewController.hideSideMenu()
        }
        }
        else{
            
            if    (indexPath.row == 4){
                self.Login()
            }
            else{
                guard let menuContainerViewController = self.menuContainerViewController else {
                    return
                }
                menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
                menuContainerViewController.hideSideMenu()
            }
        }
    }
    //MARK:- Logout
    func Login()  {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        guard let rootViewController = window.rootViewController else {
            return
        }
        Singleton.sharedInstance.guestUser = false
        let storyboard = UIStoryboard(name: "Base", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "navMainBase")
        vc.view.frame = rootViewController.view.frame
        vc.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = vc
        }, completion: { completed in
            // maybe do something here
        })

    }
    
    func logout(){
        let alert = UIAlertController(title: "Are You Sure", message:"Want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil)
        let cancelAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.prepareLogout()
            
        }
        // Add the actions
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        // Present the controller
        self.present(alert, animated: true, completion: nil)
    }
    //Api for logout
    func prepareLogout(){
        FTIndicator.showProgress(withMessage: "Requesting..")
        self.wsManager.logout(completionHandler: { (success, message) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                if success {
                    FTIndicator.dismissProgress()
                    //Set current user instace nil
                    Singleton.sharedInstance.user = nil
                    //Delete all userDefaults
                    let domain = Bundle.main.bundleIdentifier!
              UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                    //LoginFlow
                    self.pushToLoginScreen()
                } else {
                    FTIndicator.dismissProgress()
                  FTIndicator.showError(withMessage: message)
                    
                }
            });
        })
    }
    //Navigte to login Screen
    func pushToLoginScreen(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        guard let rootViewController = window.rootViewController else {
            return
        }

                    let storyboard = UIStoryboard(name: "Base", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "navMainBase")
                    vc.view.frame = rootViewController.view.frame
                    vc.view.layoutIfNeeded()
                    
                    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        window.rootViewController = vc
                    }, completion: nil)

                }
    
}
