//
//  ProfileViewController.swift
//  MangeFridge
//
//  Created by MAC on 05/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import  InteractiveSideMenu
import FTIndicator
import AlamofireImage
class ProfileViewController: UIViewController,SideMenuItemContent {
    //MARK- IBoutlet and Variables
    var wsManager = WebserviceManager()

    @IBOutlet weak var btn_Edit: UIButton!
    @IBOutlet weak var txtFld_FullName: UITextField!
    @IBOutlet weak var txtFld_Email: UITextField!
    @IBOutlet weak var btn_ShowImagePicker: UIButton!
    @IBOutlet weak var imageView_User: UIImageView!
    var updatedImage: UIImage?
    var isEdit = false
    var picker:UIImagePickerController?=UIImagePickerController()
//    var wsManager = WebserviceManager()

    //MARK- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.unEditAbleView()
        txtFld_Email.setLeftPaddingPoints(10)
        txtFld_FullName.setLeftPaddingPoints(10)
        // Do any additional setup after loading the view.
    }
    
   //setUpSimpleView
    func unEditAbleView(){
        //Intraction of views
        btn_Edit.tag = 101
        txtFld_Email.text = Singleton.sharedInstance.user.email
        txtFld_FullName.text = Singleton.sharedInstance.user.name
        
        if let image_Str = Singleton.sharedInstance.user.userImageUrlString{
         let url = NSURL(string: image_Str)
         imageView_User.af_setImage(
            withURL: url! as URL,
            placeholderImage: nil,
            filter: CircleFilter(),
            imageTransition: .flipFromBottom(0.5)
            )}
        btn_Edit.setImage(UIImage(named:"edit"), for: .normal)
        txtFld_Email.layer.borderWidth = 0.0
        txtFld_FullName.layer.borderWidth = 0.0
        btn_ShowImagePicker.isHidden = true
        txtFld_FullName.isEnabled = false
        txtFld_Email.isEnabled = false
    }
    //setUpEditableView
    func editAbleView(){
        //Intraction of views
        btn_Edit.tag = 0
        btn_Edit.setImage(UIImage(named:"save"), for: .normal)
       let myColor = UIColor.black
        txtFld_FullName.layer.borderColor = myColor.cgColor
//        txtFld_Email.layer.borderColor = myColor.cgColor
//        txtFld_Email.layer.borderWidth = 1.0
        txtFld_FullName.layer.borderWidth = 1.0
        btn_ShowImagePicker.isHidden = false
        txtFld_FullName.isEnabled = true
//        txtFld_Email.isEnabled = true
   }
    func UpdateProfile()  {

        let dict = ["id": Singleton.sharedInstance.user.id , "name" : txtFld_FullName.text!]
        FTIndicator.showProgress(withMessage: "Updating...")
       
        self.wsManager.updateProfile(parmeters: dict as! [String : String], image: updatedImage!) { (sucess, user, message) in
            if sucess{
                FTIndicator.dismissProgress()
                Singleton.sharedInstance.user = nil
                Singleton.sharedInstance.user = user
                UserDefaults.standard.set("", forKey: "user")
                let dictUser = user?.asDictionary()
                UserDefaults.standard.set(dictUser, forKey: "user")
                UserDefaults.standard.synchronize()
                FTIndicator.showSuccess(withMessage: message)
                self.unEditAbleView()
                self.isEdit = false
            }else{
                FTIndicator.dismissProgress()
                FTIndicator.showError(withMessage: message)
            }
        }
        
    }
//MARK- IBAction
    @IBAction func action_Edit(sender: UIButton){
        if sender.image(for: .normal) == UIImage(named:"edit"){
            self.editAbleView()

        }
       else{
            if isEdit == true{
            let alert = UIAlertController(title: "Are You Sure", message:"Want to update changes?", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default){
                UIAlertAction in
                self.unEditAbleView()
                self.isEdit = false
                }
            let cancelAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.UpdateProfile()
            }
            // Add the actions
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            // Present the controller
            self.present(alert, animated: true, completion: nil) }
        else{
            self.unEditAbleView()
            self.isEdit = false
        }
    }
}
    
    @IBAction func action_ShowImagePicker(_ sender: Any) {
        self.showActionSheet()
    }
    @IBAction func openMenu(_ sender: UIButton) {              showSideMenu()    }

}
//MARK:- textField Delegates
extension ProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isEdit = true
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}
