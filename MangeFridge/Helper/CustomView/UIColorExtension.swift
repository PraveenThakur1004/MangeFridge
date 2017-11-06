//
//  UIColorExtension.swift
//  Koyomi
//
//  Created by Shohei Yokoyama on 2016/10/21.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor {
   
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red   = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue  = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    struct Colorex {
        
        static let AppTextColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let AppColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

        static let AppLightColor: UIColor = #colorLiteral(red: 0.8016153574, green: 0.8348899484, blue: 0.8528134227, alpha: 1)

        static let darkBlack: UIColor = .init(hex: 0x1F1F21)
        static let lightGray: UIColor = .init(hex: 0xc3c3ca)
        static let darkGray: UIColor  = .init(hex: 0x878787)
        static let red: UIColor       = .init(hex: 0xff3b30)
        static let orange: UIColor    = .init(hex: 0xff9500)
        static let green: UIColor     = .init(hex: 0x4cd964)
        static let blue: UIColor      = .init(hex: 0x007aff)
        static let purple: UIColor    = .init(hex: 0x5856d6)
        static let yellow: UIColor    = .init(hex: 0xffcc00)
        static let tealBlue: UIColor  = .init(hex: 0x5ac8fa)
        static let pink: UIColor      = .init(hex: 0xff2d55)
    }
    
}
