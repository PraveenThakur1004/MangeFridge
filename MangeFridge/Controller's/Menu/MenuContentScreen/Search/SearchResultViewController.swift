//
//  SearchResultViewController.swift
//  MangeFridge
//
//  Created by MAC on 06/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
class SearchResultViewController: UIViewController {
  let kCellReuseIdentifier = "ItemCell"
    
    var frame : CGRect!
    @IBOutlet weak var tagBackGroundView: UIView!
    var tagView = TLTagsControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide NavigationBar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.title = "Search Result"
        self.SetBackBarButtonCustom()
        
        frame = CGRect(x:0,y:0,width:self.view.frame.size.width,height:54)
        self.tagView.frame = CGRect(x:5,y:5,width:self.frame.size.width - 10,height:44)
          self.tagView.tagsDeleteButtonColor = UIColor.red
        self.tagView.tagPlaceholder = ""
        self.tagView.backgroundColor = UIColor.lightText
        self.tagView.tagsTextColor = UIColor(red:145/255.0,green:201/255.0,blue:111/255.0,alpha:1.0)
        self.tagView.mode = .edit
        
            self.tagBackGroundView.addSubview(self.tagView)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.tagView.frame = CGRect(x:5,y:5,width:self.frame.size.width - 10,height:44)
            self.tagView.tags  = ["Ingredent1","Ingredent2","Ingredent3","Ingredent4","Ingredent5","Ingredent6"]
            self.tagView.reloadTagSubviews()
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        frame = self.tagBackGroundView.frame
    }
    
    
    //MARK- Navigation Back Button
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
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
