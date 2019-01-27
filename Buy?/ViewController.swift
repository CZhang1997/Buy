//
//  ViewController.swift
//  Buy?
//
//  Created by Churong Zhang on 1/19/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - 设置数据
    /***************************************************************/
    let url = "http://apilayer.net/api/live"
    let accessCode = "85b4af3cd505c58eecc26d3a083a4f70"
    
    let defaults = UserDefaults.standard
    
    let defaultUSDCNY = 6.8     // 默认汇率：6.8
    
    var currencyJSON : JSON?
    var input : Double?
    var states : [State]?
    
    
    var currentTextField = UITextField()
    var pickerView = UIPickerView()
    var stateNumber : Int = 0     // State Counter.
    var choosenCity : City = City()
    
    var from : Int = 0
    var to: Int = 0
    
    //MARK: - 界面元素
    /***************************************************************/
    @IBOutlet weak var realTimeCurrencySwitch: UISwitch!
    @IBOutlet weak var USDTextField: UITextField!
    @IBOutlet weak var CNYLabel: UILabel!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    
    //MARK: - 选择州/城市picker view
    /***************************************************************/
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == stateTextField {
            return states!.count
        } else {
            //if currentTextField == cityTextField
            // let choosenState : [String] = identifyState(stateCounter : i)
            return states![stateNumber].cities!.count //choosenState.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == stateTextField {
            return states![row].stateName //stateArray[row]
        } else {
            //if currentTextField == cityTextField
            // let choosenState : [String] = identifyState(stateCounter : i)
            return states![stateNumber].cities![row].cityChineseName //choosenState[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == stateTextField {
            stateNumber = row
            stateTextField.text = states![row].stateName // stateArray[row]
            defaults.set(stateTextField.text, forKey: "stateTextFieldValue")
            
        } else if currentTextField == cityTextField {
            // let choosenState : [String] = identifyState(stateCounter : stateNumber)
            cityTextField.text = states![stateNumber].cities![row].cityChineseName    //choosenState[row]
            choosenCity = states![stateNumber].cities![row]
            
            cityLabel.text = choosenCity.cityChineseName
            cityLabel.isHidden = false              // Enable city label
            
            stateTextField.isEnabled = false        // Disable state/city text field
            stateTextField.isHidden = true
            cityTextField.isEnabled = false
            cityTextField.isHidden = true
            
            self.saveChoosenCity()
        }
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        
        if currentTextField == stateTextField || currentTextField == cityTextField {
            currentTextField.inputView = pickerView
        }
    }
    
    //MARK: - 保存城市
    /***************************************************************/
    func saveChoosenCity()
    {
        defaults.set(choosenCity.cityChineseName, forKey: "cityChineseName")
        defaults.set(choosenCity.cityName, forKey: "cityName")
        defaults.set(choosenCity.stateChineseName, forKey: "stateChineseName")
        defaults.set(choosenCity.stateName, forKey: "stateName")
        defaults.set(choosenCity.saleTax, forKey: "saleTax")
    }
    
    func loadChoosenCity() -> Bool {
        let cName1 = defaults.string(forKey: "cityName")
        if cName1 != nil {
            let sName1 = defaults.string(forKey: "stateName")
            let cChinese1 = defaults.string(forKey: "cityChineseName")
            let sChinese1 = defaults.string(forKey: "stateChineseName")
            let tax1 = defaults.double(forKey: "saleTax")
            
            choosenCity = City(cName: cName1! , sName: sName1! , cChinese: cChinese1!, sChinese: sChinese1!, tax: tax1)
            return true
        } else {
            return false
        }
    }
    
    //MARK: - viewDidLoad
    /***************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realTimeCurrencySwitch.isOn = false // Default: The switch is off
        
        stateTextField.isEnabled = false    // Default: Hide the state/city text field
        stateTextField.isHidden = true
        cityTextField.isEnabled = false
        cityTextField.isHidden = true
        
        if loadChoosenCity() == true {
            cityLabel.text = choosenCity.cityChineseName
            cityLabel.isHidden = false
        }
        
        let s = State()
        states = s.logStateData()
        
    }
    
    //MARK: - 换算按键
    /***************************************************************/
    @IBAction func ExchangePressed(_ sender: UIButton) {
        print ("Pressed exchange")
        //USDTextField.isHidden = t
        USDTextField.endEditing(true)
        if let usd = Double(USDTextField.text!) {
            input = usd
            
            if realTimeCurrencySwitch.isOn {    // 实时汇率
                getCurrencyData()
            } else {                            // 非实时汇率（默认汇率）
                let output = input! * defaultUSDCNY
                calculate1(output : output)
            }
        }
    }
    
    //MARK: - 选择城市按键
    /***************************************************************/
    
    @IBAction func chooseCutyButton(_ sender: UIButton) {
        cityLabel.isHidden = true           // Disable city label
        
        stateTextField.isEnabled = true     // Enable state/city text field
        stateTextField.isHidden = false
        cityTextField.isEnabled = true
        cityTextField.isHidden = false
        
        stateTextField.text = "您所在的州"
        cityTextField.text = "您所在的城市"
    }
    
    //MARK: - 提取汇率
    /***************************************************************/
    func getCurrencyData() {
        let params: [String:String] = ["access_key": accessCode, "format" : "1"]
        print("Getting Currency Data")
        Alamofire.request(url, method: .get, parameters: params).responseJSON { respond in
            if respond.result.isSuccess {
                self.currencyJSON = JSON(respond.result.value!)
                print ("calculating")
                //print (respond)
                self.calculate()//from: "CNY",to: "JPY")
            }
            else{
                print ("connection issue")
                // print (respond)
                self.calculate()
            }
            
        }
    }
    
    //MARK: - 换算
    /***************************************************************/
    func calculate() {
        if let USDCNY = currencyJSON!["quotes"]["USDCNY"].double {
            let output = input! * USDCNY
            calculate1(output : output)
        }
        else {
            print("error 101")
        }
    }
    
    func calculate1(output : Double) {
        var outputValue = output
        
        if  choosenCity.cityName == "" {
            cityLabel.text = "您未选择城市，税率为0"
        }
        
        outputValue = output * (1 + choosenCity.saleTax)
        outputValue = Double(round(100 * outputValue)/100)
        
        print ("calculated")
        print (outputValue)
        CNYLabel.text = "¥ \(outputValue)"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currentTextField.resignFirstResponder()
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        ExchangePressed(UIButton())
    }
    
}





