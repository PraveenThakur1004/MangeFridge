//
//  AppButton.swift
//  RtooshProvider
//
//  Created by Apple on 13/10/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class AppButton: UIButton {
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
        
    
            
          
        }
    


}
