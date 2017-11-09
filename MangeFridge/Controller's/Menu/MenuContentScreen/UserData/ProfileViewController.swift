//
//  ProfileViewController.swift
//  MangeFridge
//
//  Created by MAC on 05/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import  InteractiveSideMenu

class ProfileViewController: UIViewController,SideMenuItemContent {
    @IBOutlet weak var txtFld_FullName: UITextField!
    @IBOutlet weak var txtFld_Email: UITextField!
    @IBOutlet weak var btn_ShowImagePicker: UIButton!
    @IBOutlet weak var imageView_User: UIImageView!
    var picker:UIImagePickerController?=UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func action_ShowImagePicker(_ sender: Any) {
        self.showActionSheet()
    }
    @IBAction func openMenu(_ sender: UIButton) {              showSideMenu()    }

}
//MARK:- textField Delegates
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}
