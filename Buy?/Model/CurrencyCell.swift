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
    

    var currencyName = [""]
    var currencyArray = [""]
    
    var CurrencyUsed = [1,2]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("edit cell")
    }
}
