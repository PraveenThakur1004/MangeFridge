//
//  ForgetPasswordViewController.swift
//  MangeFridge
//
//  Created by MAC on 04/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//
import UIKit
import FTIndicator
import TransitionButton
class ForgetPasswordViewController: UIViewController {
    //MARK- IBoutlet and Variable
    @IBOutlet weak var txtFld_Email: CustomTextField!
    var wsManager = WebserviceManager()
    //MARK - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide NavigationBar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //MARK- Action
    //BAck to Login
    @IBAction func dismisspresentView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    //Send Request to forgot password
    @IBAction func action_Send(_ button: TransitionButton) {
        if (txtFld_Email.text?.isEmpty)! {
            FTIndicator.showError(withMessage: "Please Enter Email")
            return
        }
        if(!Utils.isValidEmail(txtFld_Email.text!)){
            FTIndicator.showError(withMessage:"Please Enter Valid Email")
            return
        }
        let dict = ["email":txtFld_Email.text!]
        button.startAnimation()
        wsManager.forgotPassword(parameter: dict as NSDictionary, completionHandler: { (sucess, message) in
            if sucess{
                button.stopAnimation()
                FTIndicator.showSuccess(withMessage: message)
                self.dismiss(animated: true, completion: nil)
            }
            else{
                button.stopAnimation(animationStyle: .shake,  completion: {
                    FTIndicator.showError(withMessage: message)
                })
            }
        })
    }
 }
//MARK:- textField Delegates
extension ForgetPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}

