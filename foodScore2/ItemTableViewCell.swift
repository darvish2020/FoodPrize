//
//  ItemTableViewCell.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/26.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit
import FloatRatingView
class ItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet var price: UILabel!
    @IBOutlet var item: UILabel!
    @IBOutlet var itemPitcure: UIImageView!
    @IBOutlet var prizeView: FloatRatingView!
    override func awakeFromNib() {
        super.awakeFromNib()
        prizeView.editable = false
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
