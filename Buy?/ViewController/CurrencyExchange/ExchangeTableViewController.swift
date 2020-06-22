//
//  ExchangeTableViewController.swift
//  Buy?
//
//  Created by Churong Zhang on 3/19/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit
import Alamofire
import SwipeCellKit
import SwiftyJSON
import RealmSwift

class ExchangeTableViewController: UITableViewController, SelectCurrencyDelegate {
 
    @IBOutlet var currencyTableView: UITableView!
    
    var currency : Results<Currency>?

        let realm = try! Realm()

    
    var currencyJSON: JSON?
    let url = "http://apilayer.net/api/live"
    let accessCode = "85b4af3cd505c58eecc26d3a083a4f70"
    var textfieldInUse = UITextField()
    //var input: Double = 0
    var index = [IndexPath]()
    var rowSelect = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCurrency()
        currencyTableView.separatorStyle = .none
        currencyTableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "currencyCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func loadCurrency()
    {
        currency = realm.objects(Currency.self)
        if currency?.count == 0
        {
            let C1 = Currency()
            C1.currencyValue = 1
            C1.currencyName = "US Dollar"
            C1.currencyCode = "USD"
            saveCurrency(c: C1)
            let C2 = Currency()
            C2.currencyValue = 6.71
            C2.currencyName = "人民币 Chinese Yuan"
            C2.currencyCode = "CNY"
            saveCurrency(c: C2)
        }
       // textfieldInUse.t
        getCurrencyData()
    }

    func saveCurrency(c: Currency)
    {
        do {
            try realm.write {
                realm.add(c)
                //print("successful add to realm")
            }
        }
        catch {
            print("Error on saving currency \(error)")
        }
        tableView.reloadData()
    }
    // MARK: - SelectCurrencyDelegate protocol
    func userSelectCurrency(code: String, name:String)
    {
        if let selectedCurrency = currency?[rowSelect]
        {
            do {
                try realm.write {
                    selectedCurrency.currencyCode = code
                    selectedCurrency.currencyName = name
                }
            }
            catch {
                print("error on changing currency \(error)")
            }
        }
        calculate()
        tableView.reloadData()
    }
    func userAddACurrency(code: String, name:String)
    {
        let C1 = Currency()
        C1.currencyValue = 1
        C1.currencyName = name
        C1.currencyCode = code
        saveCurrency(c: C1)
        calculate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rowSelect = -1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectCurrencySegue"{
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.delegate = self
//            //  print ("\n\nprepare\n\n")
            if rowSelect >= 0
            {
                destinationVC.code = currency?[rowSelect].currencyCode
                destinationVC.index = rowSelect
            }
            else
            {
                destinationVC.index = -1
            }
        }
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currency?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as! CurrencyCell
        cell.delegate = self
        cell.CurrencyCode.text = currency?[indexPath.row].currencyCode
        cell.CurrencyName.text = currency?[indexPath.row].currencyName
        cell.CurrencyValue.tag = indexPath.row
        cell.CurrencyValue.keyboardType = .decimalPad
        cell.CurrencyValue.addDoneCancelToolbar()
        cell.CurrencyValue.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        cell.CurrencyValue.delegate = self
        cell.CurrencyValue.text = "\(currency?[indexPath.row].currencyValue ?? 0)"
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelect = indexPath.row
        textfieldInUse.endEditing(true)
        performSegue(withIdentifier: "selectCurrencySegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        //rowSelect = -1
    }
    // MARK: - calculate
    func calculate() // -> Double //from:String, to:String)
    {
        index = tableView.indexPathsForVisibleRows!
        
        for x in 0 ... index.count-1
        {
            if x != textfieldInUse.tag
            {
                if let fromCurrency = currencyJSON!["quotes"]["USD\(currency?[textfieldInUse.tag].currencyCode ?? "CNY")"].double
                {
                    let toCurrency = currencyJSON!["quotes"]["USD\(currency?[x].currencyCode ?? "CNY")"].double
                    let exchange = toCurrency! / fromCurrency
                    // input = 1
                    if let money = currency?[x]
                    {
                        let input = currency?[textfieldInUse.tag].currencyValue ?? 0.0
                        do {
                            try realm.write {
                                money.currencyValue = Double(round(input * exchange * 100.0)/100.0)
                                if money.currencyValue == 0
                                {
                                    
                                    money.currencyValue = input * exchange
                                }
                            }
                        }
                        catch {
                            print("error on saving currency value change \(error)")
                        }
                    }
                    //                    print("CurrencyUsed at is \(x) and \(currencyExchange[x])")
                    if let cell = currencyTableView.cellForRow(at: index[x]) as? CurrencyCell {
                        cell.CurrencyValue.text = "\(currency?[x].currencyValue ?? 1)"
                        
                    }
                }
                else
                {
                    print("can not find curreny")
                }
            }
        }

    }
    
    func getCurrencyData()
    {
        
        let params: [String:String] = ["access_key": accessCode, "format" : "1"]
        //print("Getting Currency Data")
        Alamofire.request(url, method: .get, parameters: params).responseJSON { respond in
            if respond.result.isSuccess {
                self.currencyJSON = JSON(respond.result.value!)
                self.calculate()//from: "CNY",to: "JPY")
            }
            else{
                print ("connection issue")
                // self.calculate(from1, to1)
            }
        }
        
    }

}

// MARK: - SwipeCell functions
extension ExchangeTableViewController: SwipeTableViewCellDelegate
{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {
            return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "删除") { action, indexPath in
            self.removeCurrency(at: indexPath)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        //       options.transitionStyle = .border
        return options
    }
    
    func removeCurrency(at:IndexPath)
    {
        if let target = currency?[at.row]
        {
            do {
                try realm.write {
                    realm.delete(target)
                }
            }
            catch {
                print("error on deleting currency. \(error)")
            }
        }
    }
}

// MARK: -TEXTFIELD functions
extension ExchangeTableViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        textfieldInUse = textField
        
        
        if let value = Double(textField.text!)
        {
            do {
                try realm.write {
                    currency?[textfieldInUse.tag].currencyValue = value
                }
            }
            catch {
                print("error on changing textfield \(error)")
            }
            
            getCurrencyData()
        }
        else
        {
            do {
                try realm.write {
                    currency?[textfieldInUse.tag].currencyValue = 0
                }
            }
            catch {
                print("error on changing textfield \(error)")
            }
            calculate()
            textField.placeholder = "Enter number only"
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //text?.resignFirstResponder()
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @Reference: https://stackoverflow.com/questions/38133853/how-to-add-a-return-key-on-a-decimal-pad-in-swift
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
