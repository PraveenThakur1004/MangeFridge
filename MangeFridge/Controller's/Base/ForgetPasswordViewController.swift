//
//  ForgetPasswordViewController.swift
//  MangeFridge
//
//  Created by MAC on 04/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

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
    
}
