//
//  ExchangeViewController.swift
//  Buy?
//
//  Created by Churong Zhang on 1/22/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ExchangeViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var currencyTableView: UITableView!
    
    
    let currency = Currency()
    var currencyJSON : JSON?
    let url = "http://apilayer.net/api/live"
    let accessCode = "85b4af3cd505c58eecc26d3a083a4f70"
    
    
    var pickerView = UIPickerView()
    var input: Double = 0
    var currentTag = 0
    var text : UITextField?
    var CurrencyUsed = [1,0,2]
    var currencyExchange:[Double] = [0,0,0]
    var index = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getCurrencyData()
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        pickerView.isHidden = true
        self.view.addSubview(pickerView)
        
//          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
//         currencyTableView.addGestureRecognizer(tapGesture)
//
        
        currencyTableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "currencyCell")
        currencyTableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CurrencyUsed.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        text?.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyCell
        
        cell.CurrencyCode.text = currency.currencyArray[CurrencyUsed[indexPath.row]]
        cell.CurrencyName.text = currency.currencyName [CurrencyUsed[indexPath.row]]
        cell.CurrencyValue.tag = indexPath.row
        cell.CurrencyValue.text = "\(currencyExchange[indexPath.row])"
        cell.CurrencyValue.keyboardType = .decimalPad
        cell.CurrencyValue.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        
        pickerView.tag = indexPath.row
        cell.addSubview(pickerView)
        
        pickerView.isHidden = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(currencyCodeTapped))
        cell.CurrencyCode.addGestureRecognizer(tapGesture)
        //  print("Tag beg: \(cell.CurrencyValue.tag)")
        cell.CurrencyValue.delegate = self
        
        index.append(indexPath)
      //  print ("append \(index.count)")
        return cell
    }
    
    
    @IBAction func addCurrency(_ sender: UIBarButtonItem) {
        print ("add currency")
    }
    
    func configureTableView()
    {
        currencyTableView.rowHeight = 500//UITableView.automaticDimension
       // currencyTableView.estimatedRowHeight = 120
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
         text = textField
        currentTag = textField.tag
       // print ("\(currentTag)")
        if let value = Double(textField.text!)
        {
            currencyExchange[currentTag] = value
            input = value
            calculate()
            //getCurrencyData()
        }
        else
        {
            
            textField.placeholder = "Enter number only"
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        text?.resignFirstResponder()
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func calculate() // -> Double //from:String, to:String)
    {
        for x in 0 ... CurrencyUsed.count-1
        {
//            if text?.text == ""
//            {
//                if let cell = currencyTableView.cellForRow(at: index[x]) as? CurrencyCell {
//                    cell.CurrencyValue.text = "\(currencyExchange[x])"
//                }
//            }
            if x != currentTag
            {
                if let fromCurrency = currencyJSON!["quotes"]["USD\(currency.currencyArray[CurrencyUsed[currentTag]])"].double
                {
                    let toCurrency = currencyJSON!["quotes"]["USD\(currency.currencyArray[CurrencyUsed[x]])"].double
                    let exchange = toCurrency! / fromCurrency
                    // input = 1
                    
                    currencyExchange[x] = Double(round(input * exchange * 100.0)/100.0)
                    if currencyExchange[x] == 0
                    {
                        currencyExchange[x] = input * exchange
                    }
                    
                    if let cell = currencyTableView.cellForRow(at: index[x]) as? CurrencyCell {
                        cell.CurrencyValue.text = "\(currencyExchange[x])"
                    }
                    //  print("from \(currency.currencyArray[CurrencyUsed[currentTag]]): \(fromCurrency)\nto \(currency.currencyArray[CurrencyUsed[x]]): \(toCurrency) \nloop \(x):\(currencyExchange[x])")
                }
            }
            
            
        }
       
        //self.tableView.reloadData()
        //SVProgressHUD.dismiss()
    }
    
    func getCurrencyData()
    {
        
        let params: [String:String] = ["access_key": accessCode, "format" : "1"]
        //print("Getting Currency Data")
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { respond in
            if respond.result.isSuccess {
                //print (respond)
                self.currencyJSON = JSON(respond.result.value!)
                //self.defaults.set(self.currencyJSON, forKey: "currencyJSON")
                //print ("calculating")
                //print (respond)
                self.calculate()//from: "CNY",to: "JPY")
            }
            else{
                print ("connection issue")
                // print (respond)
                // self.calculate(from1, to1)
            }
        }
        
    }
    @objc func tableViewTapped()
    {
        //print (1)
        text?.endEditing(true)
    }
    
    @objc func currencyCodeTapped()
    {
        print ("currency tap")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.currencyName.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currency.currencyName[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
    }
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
