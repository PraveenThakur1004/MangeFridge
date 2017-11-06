//
//  CustomView.swift
//  Tribe Explorer
//
//  Created by Apple on 17/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class CustomViewWithLessAlpha: UIView {

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
}
func configure() {
    backgroundColor = UIColor.black.withAlphaComponent(0.3)
    
    }
}
