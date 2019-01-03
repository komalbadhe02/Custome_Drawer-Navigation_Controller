///**
/**
 Custome_Drawer+Navigation_Controller
 DrawerTitleTableViewCell.swift
 Created by: KOMAL BADHE on 03/01/19
 Copyright (c) 2019 KOMAL BADHE
 */

import UIKit

class DrawerTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
