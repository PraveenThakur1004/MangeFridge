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

class DetailViewController: UIViewController{

  
    var ratingEnabled : Bool = false
    @IBOutlet weak var rateTxtView: KMPlaceholderTextView!
    @IBOutlet weak var rateSetter: HCSStarRatingView!
   // @IBOutlet weak var showRating: HCSStarRatingView!
    @IBOutlet var ratingOuterView: UIView!
    @IBOutlet weak var detailTableView: UITableView!
    weak var headerImageView: UIView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailTableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.detailTableView.rowHeight = UITableViewAutomaticDimension
        self.ratingOuterView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let frame : CGRect = CGRect(x:0,y:0,width : self.view.frame.size.width,height : self.view.frame.size.height)
        self.ratingOuterView.frame = frame
        self.view.insertSubview(self.ratingOuterView, at: 1)
        
        self.ratingOuterView.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
        self.ratingOuterView.isUserInteractionEnabled = true
        self.ratingOuterView.addGestureRecognizer(tapGesture)
        rateSetter.allowsHalfStars = true
        rateSetter.accurateHalfStars = true
        rateSetter.emptyStarColor = UIColor.lightText
        rateSetter.tintColor = UIColor(red: 247/255.0, green: 199/255.0, blue: 48/255.0, alpha: 1.0)
       rateSetter.addTarget(self, action: #selector(self.ratings), for: .valueChanged)

        
        
//        self.detailTableView.tableFooterView = footerView()
         setupParallaxHeader()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide NavigationBar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.title = "Detail"
        self.SetBackBarButtonCustom()
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
//
//    func footerView() -> UIView{
//        let footer : UIView = UIView()
//        footer.frame = CGRect(x:0,y:0,width:detailTableView.frame.size.width,height : 44)
//        let btn : UIButton = UIButton()
//        btn.frame = footer.frame
//        btn.backgroundColor = UIColor.orange
//        footer.addSubview(btn)
//
//        return footer
//    }
    
    @objc func tapAction() {
        ratingEnabled = false
        self.setView(view: self.ratingOuterView, hidden: true)
    }
    
    @objc func ratings()
    {
        print(rateSetter.value)
       
    }
    func setView(view: UIView, hidden: Bool) {
        
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
             view.isHidden = hidden
        }, completion: nil)
    
    }
    
    @IBAction func openRateAction(_ sender: Any) {
        if ratingEnabled == false{
            ratingEnabled = true
            self.setView(view: self.ratingOuterView, hidden: false)
        }else{
                ratingEnabled = false
            self.setView(view: self.ratingOuterView, hidden: true)
        }
    }
    @IBAction func rateAction(_ sender: Any) {
        ratingEnabled = false
        self.setView(view: self.ratingOuterView, hidden: true)
    }
    private func setupParallaxHeader() {
        let imageView = UIImageView()
        
        if let url = URL.init(string: "https://www.hdwallpapers.in/walls/under_the_bridge_hd_5k-wide.jpg") {
            imageView.downloadedFrom(url: url)
        }
        
        //imageView.image = UIImage(named: "profile")
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
    
  
}


extension DetailViewController : UITableViewDelegate, UITableViewDataSource  {
    //MARK: table view data source/delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
            
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

//extension DetailViewController : HCSStarRatingViewde

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
