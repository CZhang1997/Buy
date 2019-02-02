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


class ExchangeViewController: UITableViewController, UITextFieldDelegate, SelectCurrencyDelegate {
    
    
    @IBOutlet var currencyTableView: UITableView!
    
    
    let currency = Currency()
    var currencyJSON : JSON?
    let url = "http://apilayer.net/api/live"
    let accessCode = "85b4af3cd505c58eecc26d3a083a4f70"
    
    
    var pickerView = [UIPickerView]()
    var cons = [NSLayoutConstraint]()
    var input: Double = 0
    var currentTag = 0
    var text : UITextField?
    var CurrencyUsed = [1,0,2]
    var currencyExchange:[Double] = [0,0,0]
    var index = [IndexPath]()
    var rowSelect = -1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getCurrencyData()
        
      
        
//          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
//         currencyTableView.addGestureRecognizer(tapGesture)
//
//        
        currencyTableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "currencyCell")
        currencyTableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // print("numberOfRowsInSection")
        return CurrencyUsed.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // pickerView[indexPath.row].addConstraints(cons)
//        NSLayoutConstraint.activate(pickerView[indexPath.row].constraints)
//
//        pickerView[indexPath.row].isHidden = false
//        tableView.reloadData()
        rowSelect = indexPath.row
       
        performSegue(withIdentifier: "selectCurrencySegue", sender: nil)
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
        
//        cell.CurrencyPickerView.tag = indexPath.row
//        cell.CurrencyPickerView.delegate = self
//        cell.CurrencyPickerView.selectRow(CurrencyUsed[indexPath.row], inComponent: 0, animated: true)
//        cell.CurrencyPickerView.isHidden = false
//        pickerView.append(cell.CurrencyPickerView)
        
//        cons  = cell.CurrencyPickerView.constraints
//        NSLayoutConstraint.deactivate(cell.CurrencyPickerView.constraints)
//
        
//        cell.CurrencyPickerView.isHidden = true

        
       //pickerView.isHidden = false
        
        //  print("Tag beg: \(cell.CurrencyValue.tag)")
        cell.CurrencyValue.delegate = self
        
        //index.append(indexPath)
    //    print ("append \(index.count)")
        return cell
    }
    
    
    @IBAction func addCurrency(_ sender: UIBarButtonItem) {
        print ("add currency")
    }
    
    func configureTableView()
    {
        currencyTableView.rowHeight = UITableView.automaticDimension
        currencyTableView.estimatedRowHeight = 120
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
            //culate()cal
            getCurrencyData()
        }
        else
        {
            input = 0
            calculate()
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
    //    print("CurrencyUsed.count is \(CurrencyUsed.count)")
        index = tableView.indexPathsForVisibleRows!
        while index.count < CurrencyUsed.count
        {
            let newPath = IndexPath(row: index[index.count-1].row + 1, section: index[index.count-1].section)
            index.append(newPath)
          //  print ("index count = \(index.count)")
        }
        for x in 0 ... index.count-1
        {
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
//                    print("CurrencyUsed at is \(x) and \(currencyExchange[x])")
                    if let cell = currencyTableView.cellForRow(at: index[x]) as? CurrencyCell {
                        cell.CurrencyValue.text = "\(currencyExchange[x])"
                        
                    }
                }
            }
        }
       
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
                self.calculate()//from: "CNY",to: "JPY")
            }
            else{
                print ("connection issue")
                // self.calculate(from1, to1)
            }
        }
        
    }
    @objc func tableViewTapped()
    {
        //print (1)
        text?.endEditing(true)
    }
    
   
    
    func userSelectCurrency(index: Int) {
        if let fromCurrency = currencyJSON!["quotes"]["USD\(currency.currencyArray[CurrencyUsed[rowSelect]])"].double
        {
            let toCurrency = currencyJSON!["quotes"]["USD\(currency.currencyArray[index])"].double
            let exchange = toCurrency! / fromCurrency
            
            let prevValue = currencyExchange[rowSelect]
            currencyExchange[rowSelect] = Double(round(prevValue * exchange * 100.0)/100.0)
            if currencyExchange[rowSelect] < 1
            {
                currencyExchange[rowSelect] = prevValue * exchange
            }
            CurrencyUsed[rowSelect] = index
            if let cell = currencyTableView.cellForRow(at: self.index[rowSelect]) as? CurrencyCell {
                cell.CurrencyValue.text = "\(currencyExchange[rowSelect])"
                cell.CurrencyName.text = "\(currency.currencyName[index])"
                cell.CurrencyCode.text = "\(currency.currencyArray[index])"
            }
        }
        rowSelect = -1
        
    }
    func userAddACurrency(currencyIndex: Int) {
        let newPath = IndexPath(row: index[index.count-1].row + 1, section: index[index.count-1].section)
        index.append(newPath)
        print ("index count = \(index.count)")
        CurrencyUsed.append(currencyIndex)
        currencyExchange.append(0.00)
       tableView.reloadData()
        
        for x in 1 ... index.count-1
        {
            currentTag = 0
            input = currencyExchange[0]
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
                }
            
        }
        
        tableView.reloadData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectCurrencySegue"{
            let destinationVC = segue.destination as! SearchViewController
                destinationVC.delegate = self
              //  print ("\n\nprepare\n\n")
                if rowSelect >= 0
               {
                
                 destinationVC.index = CurrencyUsed[rowSelect]
                }
                else
                {
                    destinationVC.index = -1
            }
        }
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
