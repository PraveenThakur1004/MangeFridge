//
//  SearchResultViewController.swift
//  MangeFridge
//
//  Created by MAC on 06/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import AlamofireImage
import  FTIndicator
class SearchResultViewController: UIViewController {
    //MARK:- IBOutlet and Variables
    var searchResultArray = [Item]()
    var tagListArray = NSMutableArray()
    var selectedfiltersID:NSString?
    var selectedIngredientsArray = [Ingredients]()
    var frame : CGRect!
    var selectedIngredientsStringArray: NSMutableArray!
    let kCellReuseIdentifier = "ItemCell"
    var wsManager = WebserviceManager()
    @IBOutlet weak var tagBackGroundView: UIView!
    @IBOutlet weak var tableView:UITableView!
    var tagView = TLTagsControl()
    //MARK:- ViewLifeCylce
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up tagview to show selected ingredients
        tagView.tapDelegate = self
        DispatchQueue.main.async {
            self.tagView.frame = CGRect(x:5,y:5,width:self.frame.size.width - 10,height:44)
            for item in self.selectedIngredientsArray{
                let value = item.name
                self.tagListArray.add(value)
            }
            self.tagView.tags  = self.tagListArray
            self.tagView.reloadTagSubviews()
        }
       
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
        //self.tagView.tagPlaceholder = ""
        self.tagView.backgroundColor = UIColor.lightText
        self.tagView.tagsTextColor = UIColor(red:145/255.0,green:201/255.0,blue:111/255.0,alpha:1.0)
        self.tagView.mode = .edit
        self.tagBackGroundView.addSubview(self.tagView)
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
//MARK:- Extension Delegate
//Tagview
extension SearchResultViewController:TLTagsControlDelegate{
   func tagsControl(_ tagsControl: TLTagsControl!, removedAt index: Int) {
        selectedIngredientsArray.remove(at: index)
    //Search for remaining ingredient
        var selectedID = ""
    //get id's of ingredients
        for item in self.selectedIngredientsArray{
            let id = item.id
            if selectedID != ""{
                selectedID = selectedID + ",\(id)"}else{
                selectedID = id
            }
        }
        if selectedID == ""{
    self.navigationController?.popViewController(animated: true)
        }
        else
        {
            var parameters:NSDictionary = ["ingredient":selectedID,"filter":selectedfiltersID ?? ""]
            if Singleton.sharedInstance.guestUser == false{
                if let id = Singleton.sharedInstance.user.id{
                    parameters = ["ingredient":selectedID ,"user_id":id,"filter":selectedfiltersID ?? ""]
                }
                else{
                    FTIndicator.showError(withMessage: "User not exist")
                    return
                }
                
            }
            FTIndicator.showProgress(withMessage: "")
            wsManager.searchIngredents(parameters: parameters) { (sucess, items, message) in
                FTIndicator.dismissProgress()
                if sucess{
                    if (items.isEmpty){
                        FTIndicator.showError(withMessage: message)
                    }
                    else{
                        self.searchResultArray.removeAll()
                        self.searchResultArray = items
                        self.tableView.reloadData()
                    }
                }
                else{
                    if message == "No Record Found"{
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                    FTIndicator.showError(withMessage: message)
                }
            }
        }
    }
}
//Tableview Delegates
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath) as! ItemTableViewCell
        let item: Item = searchResultArray[indexPath.row]
        cell.lbl_ItemName.text = item.name
        cell.lbl_Category.text = "Category:\(item.category)"
        cell.lbl_Duration.text = "Duration:\(item.duration)"
        cell.lbl_Discription.text = item.description
        if Singleton.sharedInstance.guestUser == false{
        if item.favoritestatus == "1"{
            cell.imageView_Fav.image = UIImage(named:"favorite")
        }
        else{
            cell.imageView_Fav.image = UIImage(named:"favouriteuncheck")
            }
            
        }else{
            cell.imageView_Fav.image = nil
        }
        if let data = Double(item.ratings) {
            cell.view_Rate.value =  CGFloat(data)
        }
        if let url =  NSURL(string:Singleton.sharedInstance.baseUrl + item.image) as URL?{
            cell.thumbnailImageView.af_setImage(withURL: url as URL)}
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item: Item = searchResultArray[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Menu", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ID_DetailViewController") as! DetailViewController
        nextViewController.item = item
        self.navigationController?.pushViewController(nextViewController, animated: false)
        
    }
}

