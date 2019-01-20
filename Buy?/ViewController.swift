//
//  ViewController.swift
//  Buy?
//
//  Created by Churong Zhang on 1/19/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {



    let regionArray = ["纽约", "洛杉矶", "旧金山", "达拉斯", "芝加哥", "休斯敦", "西雅图", "迈阿密", "波士顿"]
    
    


    @IBOutlet weak var exchangeButton: UIButton!
    
    @IBOutlet weak var RegionPicker: UIPickerView!
    @IBOutlet weak var USDTextField: UITextField!
    @IBOutlet weak var CNYLabel: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regionArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regionArray[row]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        RegionPicker.delegate = self
        RegionPicker.dataSource = self

        exchangeButton.setTitle("ExChange To", for: .normal)

    }

    @IBAction func ExchangePressed(_ sender: UIButton) {
        print ("Pressed exchange")
        
    }
    
}

