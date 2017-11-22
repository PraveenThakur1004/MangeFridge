//
//  ViewController.swift
//  Detail
//
//  Created by MAC on 06/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import ParallaxHeader
import HCSStarRatingView
import KMPlaceholderTextView
import  FTIndicator
class DetailViewController: UIViewController{
    //MARK:- IBOutlet and Variable
    @IBOutlet weak var btn_ReviewAndRate:UIButton!
    @IBOutlet weak var rateTxtView: KMPlaceholderTextView!
    @IBOutlet weak var rateSetter: HCSStarRatingView!
    @IBOutlet var ratingOuterView: UIView!
    @IBOutlet weak var detailTableView: UITableView!
    weak var headerImageView: UIView?
    var item:Item!
    var wsManager = WebserviceManager()
    var ratingEnabled : Bool = false
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailTableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.detailTableView.rowHeight = UITableViewAutomaticDimension
        //seting up rating view
        self.ratingOuterView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let frame : CGRect = CGRect(x:0,y:0,width : self.view.frame.size.width,height : self.view.frame.size.height)
        self.ratingOuterView.frame = frame
        self.view.insertSubview(self.ratingOuterView, at: 1)
        self.ratingOuterView.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
        self.ratingOuterView.isUserInteractionEnabled = true
        self.ratingOuterView.addGestureRecognizer(tapGesture)
        rateSetter.emptyStarColor = UIColor.lightText
        rateSetter.tintColor = UIColor(red: 247/255.0, green: 199/255.0, blue: 48/255.0, alpha: 1.0)
        rateSetter.addTarget(self, action: #selector(self.ratings), for: .valueChanged)
        //Setup Parallax headerview
        setupParallaxHeader()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide NavigationBar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.title = "Detail"
        self.SetBackBarButtonCustom()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //MARK:- Functions
    //navigation back button
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
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        }, completion: nil)
        
    }
    private func setupParallaxHeader() {
        let imageView = UIImageView()
        if let url =  NSURL(string:Singleton.sharedInstance.baseUrl + item.image) as URL?{
            imageView.af_setImage(withURL: url as URL)}
        imageView.contentMode = .scaleAspectFill
        headerImageView = imageView
        detailTableView.parallaxHeader.view = imageView
        detailTableView.parallaxHeader.height = 250
        detailTableView.parallaxHeader.minimumHeight = 0
        detailTableView.parallaxHeader.mode = .topFill
        detailTableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            print(parallaxHeader.progress)
        }
    }
    //MARK:- Action's
    //Navigation back button action
    @objc func onClcikBack()
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    //Show ratingview
   @objc func tapAction() {
        ratingEnabled = false
        self.setView(view: self.ratingOuterView, hidden: true)
    }
    @objc func ratings()
    {
        print(rateSetter.value)
    }
    //Add to user favourite list
    @objc func action_Fav(sender:UIButton){
        if sender.tag == 1{
            sender.tag = 2
            FTIndicator.showProgress(withMessage: "")
            let parameters:NSDictionary = ["user_id":Singleton.sharedInstance.user.id!,"recipe_id":item.id,"status":"2"]
            wsManager.addToFavourite(parameters: parameters , completionHandler: { (sucess, message) in
                FTIndicator.dismissProgress()
                if sucess{
                    sender.setImage(UIImage(named:"favouriteuncheck"), for: .normal)
                    FTIndicator.showSuccess(withMessage: message)
                }else{
                    FTIndicator.showError(withMessage: message)
                }
            })
        }else{
            sender.tag = 1
            let parameters:NSDictionary = ["user_id":Singleton.sharedInstance.user.id!,"recipe_id":item.id,"status":"1"]
            FTIndicator.showProgress(withMessage: "")
            wsManager.addToFavourite(parameters: parameters , completionHandler: { (sucess, message) in
                if sucess{
                    FTIndicator.dismissProgress()
                    sender.setImage(UIImage(named:"favorite"), for: .normal)
                    FTIndicator.showSuccess(withMessage: message)
                }else{
                    FTIndicator.showError(withMessage: message)
                }
            })
            
        }
        
    }
    //Give ratings
    @IBAction func openRateAction(_ sender: Any) {
        //if guest user
        if Singleton.sharedInstance.guestUser{
            FTIndicator.showToastMessage("Please login to give ratings")
            
        }
        else{
            if ratingEnabled == false{
                ratingEnabled = true
                self.setView(view: self.ratingOuterView, hidden: false)
            }else{
                ratingEnabled = false
                self.setView(view: self.ratingOuterView, hidden: true)
            }
            
        }
    }
    //Rate
    @IBAction func rateAction(_ sender: Any) {
        if rateSetter.value == 0{
            FTIndicator.showError(withMessage: "Please select ratings first")
            return
        }
        let parameters:NSDictionary = ["user_id":Singleton.sharedInstance.user.id!,"recipe_id":item.id,"rating":rateSetter.value,"review":rateTxtView.text]
        FTIndicator.showProgress(withMessage: "")
        wsManager.rateAndReview(parameters: parameters , completionHandler: { (sucess, message) in
            FTIndicator.dismissProgress()
            if sucess{
                self.ratingEnabled = false
                self.setView(view: self.ratingOuterView, hidden: true)
                FTIndicator.showSuccess(withMessage: message)
            }else{
                FTIndicator.showError(withMessage: message)
            }
        })
        
    }
    //Show all the reviews of recipe
    @IBAction func showReviews(_ sender: UITapGestureRecognizer) {
        FTIndicator.showProgress(withMessage: "")
        wsManager.getAllReviews(recipeId: item.id) { (sucess, reviews, message) in
            FTIndicator.dismissProgress()
            if sucess{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Menu", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ID_ ShowUserFeedbackVC") as! ShowUserFeedbackVC
                nextViewController.itemArray = reviews
                self.navigationController?.pushViewController(nextViewController, animated: false)
            }else{
                FTIndicator.showError(withMessage: message)
            }
        }
        
    }
}
//MARK:- Extension Delegates
//Tableview
extension DetailViewController : UITableViewDelegate, UITableViewDataSource  {
   func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
            let lbl_ItemName : UILabel = cell.contentView.subviews[0] as! UILabel
            let view_Rating:HCSStarRatingView = cell.contentView.subviews[1] as! HCSStarRatingView
            let lbl_Reviews : UILabel = cell.contentView.subviews[2] as! UILabel
            let lbl_Duration : UILabel = cell.contentView.subviews[3] as! UILabel
            let lbl_Category : UILabel = cell.contentView.subviews[4] as! UILabel
            let btn_Favourite : UIButton = cell.contentView.subviews[5] as! UIButton
            if Singleton.sharedInstance.guestUser == false {
                btn_Favourite.isHidden = false
                if item.favoritestatus == "1"{
                    btn_Favourite.tag = 1
                    btn_Favourite.setImage(UIImage(named:"favorite"), for: .normal)
                }
                else{
                    btn_Favourite.tag = 0
                    btn_Favourite.setImage(UIImage(named:"favouriteuncheck"), for: .normal)
                }
                
                btn_Favourite.addTarget(self, action: #selector(action_Fav), for: .touchUpInside)}else{
                btn_Favourite.isHidden = true
            }
            lbl_ItemName.text = item.name
            lbl_Category.text = "Category:\(String(describing: item.category))"
            lbl_Duration.text = "Duration:\(String(describing: item.duration))"
            let reviews = item.review
            print (reviews)
            if reviews == "0"{
                lbl_Reviews.isHidden = true
            }
            else{
                lbl_Reviews.text = "(\(reviews)review)"
            }
            if let data = Double(item!.ratings) {
                view_Rating.value =  CGFloat(data)
            }
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
            let lbl_Ingredients : UILabel = cell.contentView.subviews[1] as! UILabel
            lbl_Ingredients.text = item.ingredients
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
            let lbl_Description : UILabel = cell.contentView.subviews[1] as! UILabel
            lbl_Description.text = item.description
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
//extension  ImageView
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
//MARK:- textField Delegates
extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}

