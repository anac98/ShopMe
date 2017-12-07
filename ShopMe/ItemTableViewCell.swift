//
//  ItemTableViewCell.swift
//  ShopMe
//
//  Created by Joanna Wu on 12/7/17.
//  Copyright © 2017 Joanna Wu. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQuantity: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
