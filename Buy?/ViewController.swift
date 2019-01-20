//
//  ViewController.swift
//  Buy?
//
//  Created by Churong Zhang on 1/19/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    let stateArray = ["AZ-亚利桑那州", "CA-加利福尼亚州", "CO-科罗拉多州", "FL-佛罗里达州", "GA-乔治亚州", "HI-夏威夷州", "IL-i伊利诺伊州", "MD-马里兰州", "MA-马萨诸塞州", "MI-密歇根州", "NV-内华达州", "NY-纽约州", "OR-俄勒冈州", "TX-德克萨斯州", "WA-华盛顿州"]
    let cityArray = ["纽约", "洛杉矶", "旧金山", "达拉斯", "芝加哥", "休斯敦", "西雅图", "迈阿密", "波士顿"]
    let AZ = ["凤凰城"]
    let CA = ["旧金山", "洛杉矶"]
    let CO = ["丹佛"]
    let FL = ["迈阿密", "奥兰多"]
    let GA = ["亚特兰大"]
    let HI = ["火奴鲁鲁"]
    let IL = ["芝加哥"]
    let MD = ["华盛顿特区", "巴尔的摩"]
    let MA = ["波士顿"]
    let MI = ["底特律"]
    let NV = ["拉斯维加斯"]
    let NY = ["纽约"]
    let OR = ["波特兰"]
    let TX = ["休斯敦", "达拉斯", "奥斯汀", "圣安东尼奥"]
    let WA = ["西雅图"]
    
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    var i : Int = 0
    
    @IBOutlet weak var USDTextField: UITextField!
    @IBOutlet weak var CNYLabel: UILabel!
    
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == stateTextField {
            return stateArray.count
        } else if currentTextField == cityTextField {
            switch i {
                case 0: return AZ.count
                case 1: return CA.count
                case 2: return CO.count
                case 3: return FL.count
                case 4: return GA.count
                case 5: return HI.count
                case 6: return IL.count
                case 7: return MD.count
                case 8: return MA.count
                case 9: return MI.count
                case 10: return NV.count
                case 11: return NY.count
                case 12: return OR.count
                case 13: return TX.count
                case 14: return WA.count
                default: return 0
            }
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == stateTextField {
            return stateArray[row]
        } else if currentTextField == cityTextField {
            switch i {
                case 0: return AZ[row]
                case 1: return CA[row]
                case 2: return CO[row]
                case 3: return FL[row]
                case 4: return GA[row]
                case 5: return HI[row]
                case 6: return IL[row]
                case 7: return MD[row]
                case 8: return MA[row]
                case 9: return MI[row]
                case 10: return NV[row]
                case 11: return NY[row]
                case 12: return OR[row]
                case 13: return TX[row]
                case 14: return WA[row]
                default: return nil
            }
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == stateTextField {
            switch row {
                case 0: i = 0
                case 1: i = 1
                case 2: i = 2
                case 3: i = 3
                case 4: i = 4
                case 5: i = 5
                case 6: i = 6
                case 7: i = 7
                case 8: i = 9
                case 9: i = 9
                case 10: i = 10
                case 11: i = 11
                case 12: i = 12
                case 13: i = 13
                case 14: i = 14
                default: i = 0
            }
            self.view.endEditing(true)
        } else if currentTextField == cityTextField {
            self.view.endEditing(true)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        
        if currentTextField == stateTextField || currentTextField == cityTextField {
            currentTextField.inputView = pickerView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func ExchangePressed(_ sender: UIButton) {
        print ("Pressed")
    }
    
}

