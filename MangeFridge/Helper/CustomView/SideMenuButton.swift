//
//  SideMenuButton.swift
//  Entm
//
//  Created by Apple on 16/10/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class SideMenuButton: UIButton {
    @IBInspectable var SelectedImage: UIImage?
    @IBInspectable var UnselectedImage: UIImage?
    var imageToset : UIImage!
    var ButtonImage : UIImageView!
    var SideView : UIView!

    
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
    
    var slecte : Bool = true{
        didSet{
            if self.slecte == true {
            ButtonImage.image = SelectedImage
            SideView.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.1098039216, blue: 0.1411764706, alpha: 1)
            self.setTitleColor(#colorLiteral(red: 0.9294117647, green: 0.1098039216, blue: 0.1411764706, alpha: 1), for: .normal)
            self.backgroundColor = #colorLiteral(red: 0.9418170452, green: 0.9566372037, blue: 0.9698738456, alpha: 1)
            }
            else{
                ButtonImage.image = UnselectedImage
                SideView.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.1098039216, blue: 0.1411764706, alpha: 0)
                self.setTitleColor(#colorLiteral(red: 0.6121080518, green: 0.6929129958, blue: 0.7464657426, alpha: 1), for: .normal)
                self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
    var UnSelecte : Bool = false{
        didSet{
            
            
            ButtonImage.image = UnselectedImage



        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        //        let insets = UIEdgeInsets.init(top: 2, left: 34, bottom: 2, right: 0)
        //        self.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        //        self.editingRect(forBounds: UIEdgeInsetsInsetRect(rect, insets))
        //        self.placeholderRect(forBounds: UIEdgeInsetsInsetRect(rect, insets))
        
       

        
    }
    
    func configure() {
        
        self.setTitleColor(#colorLiteral(red: 0.6121080518, green: 0.6929129958, blue: 0.7464657426, alpha: 1), for: .normal)

        SideView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 4, height: self.frame.size.height))
        self.addSubview(SideView)
        
        ButtonImage = UIImageView.init(frame: CGRect.init(x: 14, y: 10, width: 30, height: 30))
        ButtonImage.image = UnselectedImage
        self.addSubview(ButtonImage)
        
        
    }

}
