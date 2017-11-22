//
//  ShowUserFeedbackVC.swift
//  SnobbiMerchantSide
//
//  Created by MAC on 19/09/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import FTIndicator
import  AlamofireImage
class ShowUserFeedbackVC: UIViewController {
    //MARK:- IBOutlet and   Variable
    @IBOutlet weak var tableView: UITableView!
    var itemArray = [NSDictionary]()
    let wsManager = WebserviceManager()
    let kCellReuseIdentifier = "userFeedback"
    //MARK:- ViewLifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView Dynamic heigh and intraction
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 102
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide NavigationBar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.title = "Reviews"
        self.SetBackBarButtonCustom()
    }
    //MARK:- Functions
    func SetBackBarButtonCustom()
    {
        //Back buttion
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(named: "back"), for: UIControlState())
        btnLeftMenu.addTarget(self, action: #selector(self.onClcikBack), for: UIControlEvents.touchUpInside)
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        self.navigationItem.leftBarButtonItem = barButton
    }
    //Navigation back button action
    @objc func onClcikBack()
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
//MARK- Extensions
extension ShowUserFeedbackVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath) as! UserFeedbackCellTableViewCell
        cell.layer.backgroundColor = UIColor.clear.cgColor
        let item = itemArray[(indexPath as NSIndexPath).row]
        let reviewDict = item.object(forKey: "Review") as? NSDictionary
        let userDict = item.object(forKey: "User") as? NSDictionary
        var reviewMessageStr = ""
        var userNameStr = ""
        if let username = userDict?.object(forKey: "name") as? String{
            userNameStr = username
        }
        cell.userNameLabel.text = userNameStr
        if let message = reviewDict?.object(forKey: "review") as? String {
            reviewMessageStr = message
        }
        cell.feedbackLabel.text = reviewMessageStr
        if let imageUrlString  = userDict?.object(forKey: "image") as? String {
            let imageUrl = URL(string: Singleton.sharedInstance.baseUrl + imageUrlString)
            cell.thumbnailImageView.af_setImage(withURL: imageUrl!)
        }
        return cell
    }
    
}

