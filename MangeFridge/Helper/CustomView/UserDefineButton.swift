//
//  UserDefineButton.swift
//  Tribe Explorer
//
//  Created by Apple on 16/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class UserDefineButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var color: UIColor = #colorLiteral(red: 0.166698277, green: 0.3208400309, blue: 0.6536699533, alpha: 1) {
        didSet {
            layer.borderColor = color.cgColor
            setTitleColor(color, for: UIControlState())
        }
    }
    var deepColor: UIColor = .white {
        didSet {
            layer.borderColor = deepColor.cgColor
            backgroundColor = deepColor
            setTitleColor(.white, for: UIControlState())
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        
        if title(for: .normal) == "FACEBOOK"{
            backgroundColor = #colorLiteral(red: 0.2434310317, green: 0.3789075911, blue: 0.6177400947, alpha: 1)
            
            setTitleColor(UIColor.Colorex.AppTextColor, for: .normal)
            layer.borderColor  = color.cgColor
            //        contentEdgeInsets  = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
            layer.cornerRadius = 8
            layer.borderWidth = 1
            frame.size.height = 40
            layer.borderColor = #colorLiteral(red: 0.2434310317, green: 0.3789075911, blue: 0.6177400947, alpha: 1).cgColor
            layer.shadowColor = #colorLiteral(red: 0.2434310317, green: 0.3789075911, blue: 0.6177400947, alpha: 1).cgColor
            layer.shadowOpacity = 1
            layer.shadowOffset = CGSize.zero
            layer.shadowRadius = 2
        }
        else  if title(for: .normal) == "TWITTER"{
            backgroundColor = #colorLiteral(red: 0.1956644952, green: 0.8028178811, blue: 0.9901944995, alpha: 1)
            
            setTitleColor(UIColor.Colorex.AppTextColor, for: .normal)
            layer.borderColor  = color.cgColor
            //        contentEdgeInsets  = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
            layer.cornerRadius = 8
            layer.borderWidth = 1
            frame.size.height = 40
            layer.borderColor = #colorLiteral(red: 0.1956644952, green: 0.8028178811, blue: 0.9901944995, alpha: 1).cgColor
            layer.shadowColor = #colorLiteral(red: 0.1956644952, green: 0.8028178811, blue: 0.9901944995, alpha: 1).cgColor
            layer.shadowOpacity = 1
            layer.shadowOffset = CGSize.zero
            layer.shadowRadius = 2
        }
     
        else{
        
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            setBackgroundImage(#imageLiteral(resourceName: "gradient_button"), for: .normal)
//        titleEdgeInsets.top = -5
        setTitleColor(UIColor.white, for: .normal)
        layer.borderColor  = color.cgColor
//        contentEdgeInsets  = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        layer.cornerRadius = 45/2
//        layer.borderWidth = 1
//        frame.size.height = 40
//        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
            layer.masksToBounds = true
        layer.shadowColor = #colorLiteral(red: 0.9294117647, green: 0.1098039216, blue: 0.1411764706, alpha: 1).cgColor
        layer.shadowOpacity = 3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 4
        }
    }


}
