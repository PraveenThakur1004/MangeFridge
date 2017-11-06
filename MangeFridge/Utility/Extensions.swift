//
//  Extensions.swift
//  SnobbiMerchantSide
//
//  Created by MAC on 05/10/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
    
}

extension UIImage{
    func resizeImageWith(newSize: CGSize) -> UIImage {
        let scale = newSize.height / self.size.height
        let newWidth = self.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width : newWidth, height : newSize.height))
        self.draw(in: CGRect(x:0,y: 0, width:newWidth,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
}
}
