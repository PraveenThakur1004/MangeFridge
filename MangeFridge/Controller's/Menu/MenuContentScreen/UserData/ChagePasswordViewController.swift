//
//  ChagePasswordViewController.swift
//  MangeFridge
//
//  Created by MAC on 05/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit

class ChagePasswordViewController: UIViewController {

    @IBOutlet weak var txtFld_ConfirmPassword: CustomTextField!
    @IBOutlet weak var txtFld_NewPassword: CustomTextField!
    @IBOutlet weak var txtFld_CurrentPassword: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   //MARK- Action
    @IBAction func action_Done(_ sender: Any) {
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
