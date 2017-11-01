//
//  ListTableViewCell.swift
//  ShopMe
//
//  Created by Joanna Wu on 10/30/17.
//  Copyright © 2017 Joanna Wu. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    
    public func configure(text: String?, placeholder: String) {
        textField.text = text
        textField.placeholder = placeholder
        
        textField.accessibilityValue = text
        textField.accessibilityLabel = placeholder
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
