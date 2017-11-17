//
//  CircleImageView.swift
//  Corporate_Hires
//
//  Created by Apple on 24/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {

  
required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderColor  = UIColor.clear.cgColor
        layer.cornerRadius = self.frame.size.height/2
        layer.masksToBounds = true
        layer.borderWidth =  2
        layer.shadowOpacity = 2
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 1
        
    }

}
