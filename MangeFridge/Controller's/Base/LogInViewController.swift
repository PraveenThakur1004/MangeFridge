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
    @IBOutlet weak var txtFld_Email: CustomTextField!
    
    @IBOutlet weak var txt_Password: CustomTextField!
    
    var wsManager = WebserviceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Hide NavigationBar
 self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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
        button.startAnimation() // 2: Then start the animation when
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
    @IBAction func GuestLogin(_ button: TransitionButton)
        {
            button.startAnimation()
            // 2: Then start the animation when the user tap the button
            let myString = "G"
            let myAttribute = [ NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) ]
            let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            button.setAttributedTitle(myAttrString, for: .normal)
            
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                
                sleep(1) // 3: Do your networking task or background work here.
                
                DispatchQueue.main.async(execute: { () -> Void in
                    button.stopAnimation(animationStyle: .normal, completion: {
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

