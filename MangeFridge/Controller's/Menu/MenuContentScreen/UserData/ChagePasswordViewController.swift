//
//  ChagePasswordViewController.swift
//  MangeFridge
//
//  Created by MAC on 05/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import FTIndicator
class ChagePasswordViewController: UIViewController {
    //MARK:- IBOutlet and IBAction
    @IBOutlet weak var txtFld_ConfirmPassword: CustomTextField!
    @IBOutlet weak var txtFld_NewPassword: CustomTextField!
    @IBOutlet weak var txtFld_CurrentPassword: CustomTextField!
    var wsManager = WebserviceManager()
    override func viewDidLoad() {
        super.viewDidLoad()
  }
    //MARK:- Action
    @IBAction func action_Done(_ sender: Any) {
        if (txtFld_CurrentPassword.text?.isEmpty)! {
            FTIndicator.showError(withMessage:"Please Current Enter Password")
            return
        }
        if (txtFld_NewPassword.text?.isEmpty)! {
            FTIndicator.showError(withMessage:"Please New Enter Password")
            return
        }
        if txtFld_NewPassword.text! != txtFld_ConfirmPassword.text! {
            FTIndicator.showError(withMessage:"Password Not Match")
            return
        }
        let dict = ["user_id":Singleton.sharedInstance.user.id ?? "","oldPass":txtFld_CurrentPassword.text ?? "","newPass":txtFld_NewPassword.text ?? ""] as NSDictionary
        FTIndicator.showProgress(withMessage: "Updating...")
        wsManager.changePassword(parameters: dict) { (sucess, message) in
            if sucess {
                FTIndicator.dismissProgress()
                FTIndicator.showSuccess(withMessage: message); self.navigationController?.popViewController(animated: true)
            }else{
                FTIndicator.dismissProgress()
                FTIndicator.showError(withMessage: message)
            }
        }
    }
    @IBAction func dismisspresentView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
//MARK:- textField Delegates
extension ChagePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}

