//
//  CustomPopUp.swift
//  Delivery_Expert
//
//  Created by Apple on 28/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class CustomPopUp: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    var color: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) {
        didSet {
            //        layer.borderColor = color.cgColor
        }
    }
    var deepColor: UIColor = .white {
        didSet {
            //        layer.borderColor = deepColor.cgColor
            backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
        backgroundColor = UIColor.white
        layer.borderColor  = UIColor.clear.cgColor
        //        contentEdgeInsets  = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = UIColor.Colorex.AppTextColor.cgColor
        layer.masksToBounds = true
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        layer.shadowOpacity = 2
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 1
        
    }
}
