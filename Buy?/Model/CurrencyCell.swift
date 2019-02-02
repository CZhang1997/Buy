//
//  CurrencyCell.swift
//  Buy?
//
//  Created by Churong Zhang on 1/22/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit


class CurrencyCell: UITableViewCell {
    @IBOutlet weak var CurrencyName: UILabel!
    @IBOutlet weak var CurrencyCode: UILabel!
    @IBOutlet weak var CurrencyValue: UITextField!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //CurrencyPickerView.isHidden = !CurrencyPickerView.isHidden
        
        // Configure the view for the selected state
    }
}
