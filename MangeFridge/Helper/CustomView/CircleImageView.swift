//
//  CircleImageView.swift
//  Corporate_Hires
//
//  Created by Apple on 24/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {

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
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderColor  = UIColor.clear.cgColor
        //        contentEdgeInsets  = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        layer.cornerRadius = self.frame.size.height/2
        layer.masksToBounds = true
        layer.borderColor = UIColor.Colorex.AppTextColor.cgColor
        layer.borderWidth =  2

        layer.shadowColor = UIColor.Colorex.AppTextColor.cgColor
        layer.shadowOpacity = 2
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 1
        
    }

}
