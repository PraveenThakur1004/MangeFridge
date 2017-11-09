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
    var picker:UIImagePickerController?=UIImagePickerController()
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
            FTIndicator.showError(withMessage: "Please Enter Display Name")
            return
        }
        else{
            if(!Utils.isValidInput(Input: txtFld_UserName.text!)){
                FTIndicator.showError(withMessage: "Invalid Username. Require letter, digits or underscores with minimum five characters")
                return
            }
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
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                button.stopAnimation(animationStyle: .expand, completion: {
                    self.performSegue(withIdentifier: "showMenuViews", sender: self)
                    
                })
            })
        })
    }
}
//MARK:- textField Delegates
extension SignUpViwController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        
        return true
    }
}

