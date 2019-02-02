//
//  SearchViewController.swift
//  Buy?
//
//  Created by Churong Zhang on 1/27/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit

protocol SelectCurrencyDelegate
{
    func userSelectCurrency(index: Int)
    func userAddACurrency(currencyIndex: Int)
}
class SearchViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var CurrencyPicker: UIPickerView!
    
    let currency = Currency()
    var delegate : SelectCurrencyDelegate?
    var index: Int = 0
   // var addCurrency: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrencyPicker.delegate = self
        
        CurrencyPicker.selectRow(index, inComponent: 0, animated: true)
        // Do any additional setup after loading the view.
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
        
        if index >= 0
        {
            delegate?.userSelectCurrency(index: row)
        }
        else
        {
            delegate?.userAddACurrency(currencyIndex: row)
        }
        
        self.navigationController?.popViewController(animated: true)
        
        //self.dismiss(animated: true, completion: nil)
        
    }
//    func changeCurrencyIndexAt(index: Int) {
//        print("got here")
//        CurrencyPicker.selectRow(index, inComponent: 0, animated: true)
//    }
//
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
