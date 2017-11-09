//
//  FoodViewController.swift
//  MangeFridge
//
//  Created by MAC on 06/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import  InteractiveSideMenu
class FoodViewController: UIViewController,SideMenuItemContent {
    let kCellReuseIdentifier = "ItemCell"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   @IBAction func openMenu(_ sender: UIButton) {              showSideMenu()    }

}
//MARK- Extensions
extension FoodViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath) as! ItemTableViewCell
        //        cell.layer.backgroundColor = UIColor.clear.cgColor
        //        let item = itemArray[(indexPath as NSIndexPath).row]
        //        let reviewDict = item.object(forKey: "Review") as? NSDictionary
        //        let userDict = item.object(forKey: "User") as? NSDictionary
        //        var reviewMessageStr = ""
        //        var imageUrlStr = ""
        //        var userNameStr = ""
        //        if let username = userDict?.object(forKey: "image") as? String{
        //            userNameStr = username
        //        }
        //        cell.userNameLabel.text = userNameStr
        //        if let message = reviewDict?.object(forKey: "message") as? String {
        //            reviewMessageStr = message
        //        }
        //        cell.feedbackLabel.text = reviewMessageStr
        //
        //        if let imageUrlString  = userDict?.object(forKey: "image") as? String {
        //            imageUrlStr = imageUrlString
        //        }
        //        let imageUrl = URL(string:imageUrlStr)
        //        cell.thumbnailImageView.kf.setImage(with:imageUrl, placeholder: UIImage(named:"placeholderImage"), options: nil, progressBlock: nil,  completionHandler: { image, error, cacheType, imageURL in})
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        //        guard let menuContainerViewController = self.menuContainerViewController else {
        //            return
        //        }
        //
        //        menuContainerViewController.selectContentViewController(menuContainerViewController.contentViewControllers[indexPath.row])
        //        menuContainerViewController.hideSideMenu()
    }
}

