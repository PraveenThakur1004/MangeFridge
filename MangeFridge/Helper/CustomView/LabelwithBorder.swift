//
//  LabelwithBorder.swift
//  Delivery_Expert
//
//  Created by Apple on 06/09/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class LabelwithBorder: UILabel {
    @IBInspectable var image: UIImage?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        // Drawing code
        let insets = UIEdgeInsets.init(top: 0, left: 4, bottom: 0, right: 0)
        self.drawText(in: UIEdgeInsetsInsetRect(rect, insets))

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
                backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderColor  = UIColor.clear.cgColor
        layer.masksToBounds = true

        layer.cornerRadius = 8


        
        layer.masksToBounds = false
//                layer.shadowColor = UIColor.red.cgColor
//                layer.shadowOpacity = 4
//                layer.shadowOffset = CGSize.zero
//                layer.shadowRadius = 2
        
        layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2
        
    }
}
