//
//  ItemTableViewCell.swift
//  foodScore2
//
//  Created by Tsai Meng Han on 2020/2/26.
//  Copyright © 2020 Tsai Meng Han. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet var prizeImage: UIImageView!
    @IBOutlet var price: UILabel!
    @IBOutlet var item: UILabel!
    @IBOutlet var itemPitcure: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
