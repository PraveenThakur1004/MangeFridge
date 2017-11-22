//
//  ViewController.swift
//  MangeFridge
//
//  Created by MAC on 03/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import  UIKit
import  TransitionButton
import  FTIndicator
class LogInViewController: UIViewController {
    //MARK- IBOutlet and Variables
    @IBOutlet weak var txtFld_Email: CustomTextField!
    @IBOutlet weak var txt_Password: CustomTextField!
    var wsManager = WebserviceManager()
    //MARK- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide NavigationBar
     self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
   //MARK- IBAction
    //Login
    @IBAction func actionLogIn(_ button: TransitionButton) {
        
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
        if (txt_Password.text?.isEmpty)! {
            FTIndicator.showError(withMessage:"Please Enter password")
            return
        }
        button.startAnimation()
        let dict = ["email": self.txtFld_Email.text! , "pass" : self.txt_Password.text! , "deviceToken" : "hjfglkr" , "deviceType" : "IOS"] as NSDictionary
        wsManager.login(parameters: dict) { (status,user, message) in
            if status{
               button.stopAnimation(animationStyle: .expand, completion: {})
                Singleton.sharedInstance.user = user
                
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
    //Login as guest
    @IBAction func GuestLogin(_ button: TransitionButton)
    {
        let myString = "G"
        button.startAnimation()
        let myAttribute = [ NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.setAttributedTitle(myAttrString, for: .normal)
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            sleep(1)
            DispatchQueue.main.async(execute: { () -> Void in
           button.stopAnimation(animationStyle: .normal, completion: {
            //Set boolen true to sigleton is login as guest
                    Singleton.sharedInstance.guestUser = true
                    self.SendToHome()
                    })
            })
        })
        
    }
    //MARK:- Functions
    func SendToHome()  {
        self.performSegue(withIdentifier: "showMenuViews", sender: self)
    }
}
//MARK:- textField Delegates
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == txtFld_Email){
            txt_Password.becomeFirstResponder();
        }else{
            textField.resignFirstResponder();
        }
        textField.borderStyle = UITextBorderStyle.none
        return true
    }
}

