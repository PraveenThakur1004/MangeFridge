//
//  TextfieldWithImage.swift
//  Delivery_Expert
//
//  Created by Apple on 06/09/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class TextfieldWithImage: UITextField {
    @IBInspectable var image: UIImage?

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let padding = UIEdgeInsets(top: 0, left: 40 , bottom: 0, right: 5);

    override func draw(_ rect: CGRect) {
        // Drawing code

//        let insets = UIEdgeInsets.init(top: 2, left: 34, bottom: 2, right: 0)
//        self.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
//        self.editingRect(forBounds: UIEdgeInsetsInsetRect(rect, insets))
//        self.placeholderRect(forBounds: UIEdgeInsetsInsetRect(rect, insets))

        let img = UIImageView.init(frame: CGRect.init(x: 4, y: 5, width: 30, height: 30))
        img.image = image
        self.addSubview(img)
        
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
