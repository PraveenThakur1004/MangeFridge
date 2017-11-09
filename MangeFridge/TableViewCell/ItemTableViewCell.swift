//
//  ItemTableViewCell.swift
//  MangeFridge
//
//  Created by MAC on 06/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit
import HCSStarRatingView
class ItemTableViewCell: UITableViewCell {
    ////MARK:- IBOutlet
    @IBOutlet weak var  thumbnailImageView: UIImageView!
    @IBOutlet weak var  lbl_Duration: UILabel!
    @IBOutlet weak var  lbl_Category: UILabel!
    @IBOutlet weak var  lbl_Discription: UILabel!
    @IBOutlet weak var  lbl_ItemName: UILabel!
  
    @IBOutlet weak var imageView_Fav: UIImageView!
    @IBOutlet weak var view_Rate: HCSStarRatingView!
    ////MARK:- IBInspectable
    @IBInspectable var userImage: UIImage? {
        didSet {
            thumbnailImageView.image = userImage
        }
    }
    @IBInspectable var duration: String?
        {
        didSet{
            lbl_Duration.text = duration
        }
    }
    @IBInspectable var category: String?
        {
        didSet{
            lbl_Category.text = category
        }
    }
    @IBInspectable var descrip: String?
        {
        didSet{
            lbl_Discription.text = descrip
        }
    }
    @IBInspectable var itemName: String?
        {
        didSet{
            lbl_ItemName.text = itemName
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        //
        //        thumbnailImageView.image = nil
        //        lbl_Duration.text = ""
        //        lbl_Category.text = ""
        //        lbl_Discription.text = ""
        //        lbl_ItemName.text = ""
        
        
    }
}

