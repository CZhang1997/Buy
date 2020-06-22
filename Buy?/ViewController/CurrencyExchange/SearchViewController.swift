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
    func userSelectCurrency(code: String, name:String)
    func userAddACurrency(code: String, name:String)
}

class SearchViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var CurrencyPicker: UIPickerView!
    
    let currency = Currency()
    var delegate : SelectCurrencyDelegate?
    var index: Int = 0
    var selectedValue = 0
    var code: String?
    
   // var addCurrency: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrencyPicker.delegate = self
        if code != nil
        {
            if let i = currencyArray.firstIndex(of: code!)
            {
                CurrencyPicker.selectRow(i, inComponent: 0, animated: true)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyNames.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyNames[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = row
        //self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func selectPressed(_ sender: Any) {
        if code != nil
        {
            delegate?.userSelectCurrency(code: currencyArray[selectedValue], name: currencyNames[selectedValue])
        }
        else
        {
            delegate?.userAddACurrency(code: currencyArray[selectedValue], name: currencyNames[selectedValue])
        }
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    let currencyArray = ["USD", "CNY","BTC","AFN", "ALL", "DZD", "AOA", "ARS", "AMD", "AWG", "AUD", "AZN", "BSD", "BHD", "BDT", "BBD", "BYR", "BZD", "BMD", "BTN", "BTC", "BOB", "BAM", "BWP", "BRL", "GBP", "BND", "BGN", "BIF", "KHR", "CAD", "CVE", "KYD", "XOF", "XAF", "XPF", "CLP", "CLF", "CNY", "COP", "KMF", "CDF", "CRC", "HRK", "CUC", "CUP", "CZK", "DKK", "DJF", "DOP", "XCD", "EGP", "ERN", "ETB", "EUR", "FKP", "FJD", "GMD", "GEL", "GHS", "GIP", "XAU", "GTQ", "GGP", "GNF", "GYD", "HTG", "HNL", "HKD", "HUF", "ISK", "INR", "IDR", "IRR", "IQD", "ILS", "JMD", "JPY", "JEP", "JOD", "KZT", "KES", "KWD", "KGS", "LAK", "LVL", "LBP", "LSL", "LRD", "LYD", "LTL", "MOP", "MKD", "MGA", "MWK", "MYR", "MVR", "IMP", "MRO", "MUR", "MXN", "MDL", "MNT", "MAD", "MZN", "MMK", "NAD", "NPR", "ANG", "TWD", "NZD", "NIO", "NGN", "KPW", "NOK", "OMR", "PKR", "PAB", "PGK", "PYG", "PEN", "PHP", "PLN", "QAR", "RON", "RUB", "RWF", "SHP", "SVC", "WST", "STD", "SAR", "RSD", "SCR", "SLL", "XAG", "SGD", "SBD", "SOS", "ZAR", "KRW", "XDR", "LKR", "SDG", "SRD", "SZL", "SEK", "CHF", "SYP", "TJS", "TZS", "THB", "TOP", "TTD", "TND", "TRY", "TMT", "UGX", "UAH", "AED", "USD", "UYU", "UZS", "VUV", "VEF", "VND", "YER", "ZMW", "ZMK", "ZWL"]
    //["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencyNames = [ "US Dollar", "人民币 Chinese Yuan", "Bitcoin",
                          "Afghan Afghani",
                          "Albanian Lek",
                          "Algerian Dinar",
                          "Angolan Kwanza",
                          "Argentine Peso",
                          "Armenian Dram",
                          "Aruban Florin",
                          "Australian Dollar",
                          "Azerbaijani Manat",
                          "Bahamian Dollar",
                          "Bahraini Dinar",
                          "Bangladeshi Taka",
                          "Barbadian Dollar",
                          "Belarusian Ruble",
                          "Belize Dollar",
                          "Bermudan Dollar",
                          "Bhutanese Ngultrum",
                          "Bitcoin",
                          "Bolivian Boliviano",
                          "Bosnia-Herzegovina Convertible Mark",
                          "Botswanan Pula",
                          "Brazilian Real",
                          "British Pound Sterling",
                          "Brunei Dollar",
                          "Bulgarian Lev",
                          "Burundian Franc",
                          "Cambodian Riel",
                          "Canadian Dollar",
                          "Cape Verdean Escudo",
                          "Cayman Islands Dollar",
                          "CFA Franc BCEAO",
                          "CFA Franc BEAC",
                          "CFP Franc",
                          "Chilean Peso",
                          "Chilean Unit of Account (UF)",
                          "人民币 Chinese Yuan",
                          "Colombian Peso",
                          "Comorian Franc",
                          "Congolese Franc",
                          "Costa Rican Colón",
                          "Croatian Kuna",
                          "Cuban Convertible Peso",
                          "Cuban Peso",
                          "Czech Republic Koruna",
                          "Danish Krone",
                          "Djiboutian Franc",
                          "Dominican Peso",
                          "East Caribbean Dollar",
                          "Egyptian Pound",
                          "Eritrean Nakfa",
                          "Ethiopian Birr",
                          "Euro",
                          "Falkland Islands Pound",
                          "Fijian Dollar",
                          "Gambian Dalasi",
                          "Georgian Lari",
                          "Ghanaian Cedi",
                          "Gibraltar Pound",
                          "Gold (troy ounce)",
                          "Guatemalan Quetzal",
                          "Guernsey Pound",
                          "Guinean Franc",
                          "Guyanaese Dollar",
                          "Haitian Gourde",
                          "Honduran Lempira",
                          "Hong Kong Dollar",
                          "Hungarian Forint",
                          "Icelandic Króna",
                          "Indian Rupee",
                          "Indonesian Rupiah",
                          "Iranian Rial",
                          "Iraqi Dinar",
                          "Israeli New Sheqel",
                          "Jamaican Dollar",
                          "Japanese Yen",
                          "Jersey Pound",
                          "Jordanian Dinar",
                          "Kazakhstani Tenge",
                          "Kenyan Shilling",
                          "Kuwaiti Dinar",
                          "Kyrgystani Som",
                          "Laotian Kip",
                          "Latvian Lats",
                          "Lebanese Pound",
                          "Lesotho Loti",
                          "Liberian Dollar",
                          "Libyan Dinar",
                          "Lithuanian Litas",
                          "Macanese Pataca",
                          "Macedonian Denar",
                          "Malagasy Ariary",
                          "Malawian Kwacha",
                          "Malaysian Ringgit",
                          "Maldivian Rufiyaa",
                          "Manx pound",
                          "Mauritanian Ouguiya",
                          "Mauritian Rupee",
                          "Mexican Peso",
                          "Moldovan Leu",
                          "Mongolian Tugrik",
                          "Moroccan Dirham",
                          "Mozambican Metical",
                          "Myanma Kyat",
                          "Namibian Dollar",
                          "Nepalese Rupee",
                          "Netherlands Antillean Guilder",
                          "New Taiwan Dollar",
                          "New Zealand Dollar",
                          "Nicaraguan Córdoba",
                          "Nigerian Naira",
                          "North Korean Won",
                          "Norwegian Krone",
                          "Omani Rial",
                          "Pakistani Rupee",
                          "Panamanian Balboa",
                          "Papua New Guinean Kina",
                          "Paraguayan Guarani",
                          "Peruvian Nuevo Sol",
                          "Philippine Peso",
                          "Polish Zloty",
                          "Qatari Rial",
                          "Romanian Leu",
                          "Russian Ruble",
                          "Rwandan Franc",
                          "Saint Helena Pound",
                          "Salvadoran Colón",
                          "Samoan Tala",
                          "São Tomé and Príncipe Dobra",
                          "Saudi Riyal",
                          "Serbian Dinar",
                          "Seychellois Rupee",
                          "Sierra Leonean Leone",
                          "Silver (troy ounce)",
                          "Singapore Dollar",
                          "Solomon Islands Dollar",
                          "Somali Shilling",
                          "South African Rand",
                          "South Korean Won",
                          "Special Drawing Rights",
                          "Sri Lankan Rupee",
                          "Sudanese Pound",
                          "Surinamese Dollar",
                          "Swazi Lilangeni",
                          "Swedish Krona",
                          "Swiss Franc",
                          "Syrian Pound",
                          "Tajikistani Somoni",
                          "Tanzanian Shilling",
                          "Thai Baht",
                          "Tongan Paʻanga",
                          "Trinidad and Tobago Dollar",
                          "Tunisian Dinar",
                          "Turkish Lira",
                          "Turkmenistani Manat",
                          "Ugandan Shilling",
                          "Ukrainian Hryvnia",
                          "United Arab Emirates Dirham",
                          "United States Dollar",
                          "Uruguayan Peso",
                          "Uzbekistan Som",
                          "Vanuatu Vatu",
                          "Venezuelan Bolívar Fuerte",
                          "Vietnamese Dong",
                          "Yemeni Rial",
                          "Zambian Kwacha",
                          "Zambian Kwacha (pre-2013)",
                          "Zimbabwean Dollar"]
    
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
