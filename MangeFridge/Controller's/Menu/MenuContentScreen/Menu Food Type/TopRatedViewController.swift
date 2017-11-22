//
//  TopRatedViewController.swift
//  MangeFridge
//
//  Created by MAC on 06/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import  InteractiveSideMenu
import FTIndicator
import AlamofireImage
class TopRatedViewController: UIViewController,SideMenuItemContent {
    //MARK:- IBOutlet and Variable
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var view_NoData:UIView!
    var itemArray = [Item]()
     var wsManager = WebserviceManager()
   let kCellReuseIdentifier = "ItemCell"
    //MARK:- ViewLife cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemArray.removeAll()
        self.tableView.reloadData()
        //Add no data view
        self.view_NoData.frame = CGRect(x: 0, y:104, width: self.view.frame.size.width, height: self.view.frame.size.height-104)
        self.view.addSubview(self.view_NoData)
        self.view.bringSubview(toFront: self.view_NoData)
        self.getItems()
    }
    //Get All Top Rated Racipe
    func getItems(){
        FTIndicator.showProgress(withMessage: "Loading...")
        wsManager.getTopRatedRecipe{ (sucess, items, message) in
            FTIndicator.dismissProgress()
            if sucess{
                if items.isEmpty{
                    FTIndicator.showError(withMessage: "No data found")
                }
                else{
                    self.view_NoData.removeFromSuperview()
                    self.itemArray = items
                    self.tableView.reloadData()
                }
            }else{
                FTIndicator.showError(withMessage: message)
            }
        }
        
    }
   @IBAction func openMenu(_ sender: UIButton) {              showSideMenu()    }

}
extension TopRatedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath) as! ItemTableViewCell
        let item: Item = itemArray[indexPath.row]
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
        let item: Item = itemArray[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Menu", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ID_DetailViewController") as! DetailViewController
        nextViewController.item = item
        self.navigationController?.pushViewController(nextViewController, animated: false)
        
    }
}

