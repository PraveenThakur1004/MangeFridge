//
//  AppTextField.swift
//  Delivery_Expert
//
//  Created by Apple on 25/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure() {
       backgroundColor = UIColor.clear
        textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        attributedPlaceholder = NSAttributedString(string: placeholder!,
                                                   attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        font = UIFont(name: "HelveticaNeue", size: 16)
        layer.borderColor  = UIColor.white.cgColor
        layer.borderWidth  = 1.0
        layer.cornerRadius = 25.0
        textColor = UIColor.white
       }
}
