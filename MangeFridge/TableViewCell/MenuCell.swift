//
//  MenuCell.swift
//  MangeFridge
//
//  Created by MAC on 06/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var imageViewMenuImage: UIImageView!
    @IBOutlet weak var lbl_MenuName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
