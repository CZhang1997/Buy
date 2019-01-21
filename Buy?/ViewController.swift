//
//  ViewController.swift
//  Buy?
//
//  Created by Churong Zhang on 1/19/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    let stateArray = ["AZ-亚利桑那州", "CA-加利福尼亚州", "CO-科罗拉多州", "FL-佛罗里达州", "GA-乔治亚州", "HI-夏威夷州", "IL-伊利诺伊州", "MD-马里兰州", "MA-马萨诸塞州", "MI-密歇根州", "NV-内华达州", "NY-纽约州", "OR-俄勒冈州", "TX-德克萨斯州", "WA-华盛顿州"]
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
    var i : Int = 0     // State Counter.
    var chooseCity : String = ""
    
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
            let choosenState : [String] = identifyState(stateCounter : i)
            return choosenState.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == stateTextField {
            return stateArray[row]
        } else if currentTextField == cityTextField {
            let choosenState : [String] = identifyState(stateCounter : i)
            return choosenState[row]
        } else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == stateTextField {
            i = row
            stateTextField.text = stateArray[row]
            self.view.endEditing(true)
        } else if currentTextField == cityTextField {
            let choosenState : [String] = identifyState(stateCounter : i)
            cityTextField.text = choosenState[row]
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
    
    
    
    
    
    func identifyState(stateCounter : Int) -> [String] {
        switch stateCounter {
            case 0: return AZ
            case 1: return CA
            case 2: return CO
            case 3: return FL
            case 4: return GA
            case 5: return HI
            case 6: return IL
            case 7: return MD
            case 8: return MA
            case 9: return MI
            case 10: return NV
            case 11: return NY
            case 12: return OR
            case 13: return TX
            case 14: return WA
            default: return AZ
        }
        
    }
    
    
    
}





