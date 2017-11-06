//
//  ImageChangeColor.swift
//  Delivery_Expert
//
//  Created by Apple on 08/09/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ImageChangeColor: UIImageView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    func configure() {
        //        backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.1294117719, blue: 0.1411764771, alpha: 1)
        
        
        let origImage = image
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        image = tintedImage
        tintColor = UIColor.black
        
        //        
    }
}
