//
//  ViewController.swift
//  Buy?
//
//  Created by Churong Zhang on 1/19/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fromCurrency: UITextField!
    @IBOutlet weak var toCurrency: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func ExchangePressed(_ sender: UIButton) {
        print ("Pressed")
    }
    
}

