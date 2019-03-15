//
//  PlaceCell.swift
//  TravelWishList
//
//  Created by Cara on 3/15/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var visitedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.adjustsFontForContentSizeCategory = true
        visitedLabel.adjustsFontForContentSizeCategory = true
    }
    
    
}
