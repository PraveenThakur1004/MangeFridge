//
//  ForgetPasswordViewController.swift
//  MangeFridge
//
//  Created by MAC on 04/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import FTIndicator
class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var txtFld_Email: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide NavigationBar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    //MARK- Action
    @IBAction func dismisspresentView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func action_Send(_ sender: Any) {
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
    }
    
}
//MARK:- textField Delegates
extension ForgetPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder();
        return true
    }
}
