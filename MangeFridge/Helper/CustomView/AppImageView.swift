//
//  AppImageView.swift
//  RtooshProvider
//
//  Created by Apple on 13/10/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class AppImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
      
        layer.masksToBounds = true
        
        
    }
}
