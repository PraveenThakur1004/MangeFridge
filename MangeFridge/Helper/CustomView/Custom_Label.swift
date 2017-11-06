//
//  Custom_Label.swift
//  Corporate_Hires
//
//  Created by Apple on 23/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class Custom_Label: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
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
        //        backgroundColor = #colorLiteral(red: 0.166698277, green: 0.3208400309, blue: 0.6536699533, alpha: 1)
//        textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        font = UIFont.boldSystemFont(ofSize: 15)
        layer.borderColor  = UIColor.clear.cgColor
        //        contentEdgeInsets  = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        layer.cornerRadius = 0
//        layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
//        layer.shadowOpacity = 1
//        layer.shadowOffset = CGSize.zero
//        layer.shadowRadius = 1
        
    }

}
