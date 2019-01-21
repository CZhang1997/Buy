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

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {



    let regionArray = ["纽约", "洛杉矶", "旧金山", "达拉斯", "芝加哥", "休斯敦", "西雅图", "迈阿密", "波士顿"]
    let currencyCode = ["CNY","other"]
    let url = "http://apilayer.net/api/live"
    let accessCode = ""
    
    var currencyJSON : JSON?
    var input : Double?
    
    


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
        exchangeButton.setTitle("ExChange", for: .normal)

    }

    @IBAction func ExchangePressed(_ sender: UIButton) {
        print ("Pressed exchange")
        if let usd = Double(USDTextField.text!) {
            input = usd
            print ("double")
            getCurrencyData()
        }
        else
        {
            CNYLabel.text = "enter number only"
        }
        
    }
    
    func calculate()
    {
        if let USDCNY = currencyJSON!["quotes"]["USDCNY"].double {
            let change = input! * USDCNY
            CNYLabel.text = "\(change)"
            
        }
    }
    
    func getCurrencyData()
    {
        
        let params: [String:String] = ["access_key": accessCode, "format" : "1"]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { respond in
            if respond.result.isSuccess {
                //print (respond)
                self.currencyJSON = JSON(respond.result.value!)
                self.calculate()
            }
            else{
                print ("connection issue")
                print (respond)
            }
            
        }
    }
    
    
    
}

