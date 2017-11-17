//
//  SignUpViwController.swift
//  MangeFridge
//
//  Created by MAC on 03/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import  UIKit
import  TransitionButton
import  FTIndicator

class SignUpViwController: UIViewController {
    
    @IBOutlet weak var imageView_User: CircleImageView!
    @IBOutlet weak var txtFld_ConfirmPassword: UITextField!
    @IBOutlet weak var txtFld_Password: UITextField!
    @IBOutlet weak var txtFld_Email: UITextField!
    @IBOutlet weak var txtFld_UserName: UITextField!
    var wsManager = WebserviceManager()
    var selectedImage: UIImage?
   var picker:UIImagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide NavigationBar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func back(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func action_ShowImagePicker(_ sender: Any) {
        self.showActionSheet()
    }
    @IBAction func actionSignUp(_ button: TransitionButton) {
        if (txtFld_UserName.text?.isEmpty)! {
            FTIndicator.showError(withMessage: "Please Enter  Name")
            return
        }
        else{
//            if(!Utils.isValidInput(Input: txtFld_UserName.text!)){
//                FTIndicator.showError(withMessage: "Invalid Username. Require letter, digits or underscores with minimum five characters")
//                return
//            }
        }
        if (txtFld_Email.text?.isEmpty)! {
            FTIndicator.showError(withMessage: "Please Enter Email")
            return
        }
        else{
            if(!Utils.isValidEmail(txtFld_Email.text!)){
                FTIndicator.showError(withMessage:"Please Enter Valid Email")
                return
            }
        }
        if (txtFld_Password.text?.isEmpty)! {
            FTIndicator.showError(withMessage:"Please Enter password")
            return
        }
            
        else{
            if((txtFld_Password.text?.characters.count)! < 6){
                FTIndicator.showError(withMessage:"Password is not long enough")
                return
            }
        }
        if(self.txtFld_Password.text != self.txtFld_ConfirmPassword.text){
            FTIndicator.showError(withMessage:"Password mismatch")
            return
        }
        
        button.startAnimation() // 2: Then start the animation when the user tap the button
        let dict = ["name": self.txtFld_UserName.text!,
                    "email" : self.txtFld_Email.text!,
                    "password" : self.txtFld_Password.text!,
                    "deviceToken" : "jfskn.gkq",
        "deviceType" : "IOS"] as [String:String]
       
        self.wsManager.signUp(parmeters: dict, image: imageView_User.image!) { (status, user, message) in
            if status{
                button.stopAnimation(animationStyle: .expand, completion: {})
                Singleton.sharedInstance.user = user; 
                
                let dictUser = user?.asDictionary()
                UserDefaults.standard.set(dictUser, forKey: "user")
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "showMenuViews", sender: self)
                
            }
            else{
                button.stopAnimation(animationStyle: .shake, completion: {
                    FTIndicator.showError(withMessage: message)
                    
                })
            }
        }
    }
}
//MARK:- textField Delegates
extension SignUpViwController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        
        return true
    }
}

