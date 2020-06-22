//
//  TipsViewController.swift
//  Buy?
//
//  Created by Churong Zhang on 3/18/19.
//  Copyright © 2019 Churong Zhang. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {

    @IBOutlet weak var priceInput: UITextField!{    didSet { priceInput.addDoneCancelToolbar()}}
    @IBOutlet weak var guestInput: UITextField!{    didSet {    guestInput.addDoneCancelToolbar() } }
    @IBOutlet weak var foodSlider: UISlider!  {     didSet {    setSlider(min: 0, max: 100, value: 75, slider: foodSlider)
                                                                foodScoreLabel.text = "75" }}
    @IBOutlet weak var serviceSlider: UISlider!{    didSet {setSlider(min: 0, max: 100, value: 75, slider: serviceSlider)
                                                                serviceScroeLabel.text = "75"}}
    @IBOutlet weak var tipsSlider: UISlider!{   didSet {setSlider(min: 0, max: 30, value: 15, slider: tipsSlider)}}
    @IBOutlet weak var tipPerDisplay: UILabel!
    @IBOutlet weak var splitSlider: UISlider! { didSet {setSlider(min: 1, max: 1, value: 1, slider: splitSlider)}}
    @IBOutlet weak var splitDisplay: UILabel!
    @IBOutlet weak var tipValueDisplay: UILabel!
    @IBOutlet weak var totalDisplay: UILabel!
    @IBOutlet weak var foodScoreLabel: UILabel!
    @IBOutlet weak var serviceScroeLabel: UILabel!
    // for other language
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var guestLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var score2Label: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var tipsLabel2: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var getSuggestionButton: UIButton!
    
    var price : Double = 0
    var guestNumber : Int = 1
   
    var foodScore: Int {
        get { return Int(foodSlider.value) }
        set { foodScoreLabel.text = "\(newValue)"}
    }
    var serviceScore: Int {
        get { return Int(serviceSlider.value)}
        set { serviceScroeLabel.text = "\(newValue)"}
    }
    var tipsPercent : Int {
        get { return Int(tipsSlider.value)}
        set { tipsSlider.value = Float(newValue)
                tipPerDisplay.text = "\(newValue) %"}}
    var splitValue : Int {
        get { return Int(splitSlider.value)}
        set { splitDisplay.text = "\(newValue)" }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceInput.delegate = self
        guestInput.delegate = self
        guestInput.keyboardType = .numberPad
        priceInput.keyboardType = .decimalPad
        
        if Locale.current.languageCode == "zh"
        {
            priceLabel.text = "价钱:$"
            guestLabel.text = "人数："
            scoreLabel.text = "分数："
            score2Label.text = "分数："
            tipsLabel.text = "小费% "
            tipsLabel2.text = "小费: $"
            splitLabel.text = "分开算"
            totalLabel.text = "总价"
            getSuggestionButton.setTitle("价钱", for: .normal)
        }
    }
    
    @IBAction func getSuggestionPressed(_ sender: Any) {
        let score = (Float (foodScore + serviceScore) / 200.0)
        tipsPercent = Int (score * 22.0)
        calculateTips()
        
    }
    func calculateTips()
    {
        let tips = price * (Double (tipsPercent) / 100) / Double (splitValue)
        let reducetips = Double(Int(tips * 100.0)) / 100.0
        tipValueDisplay.text = "$ \(reducetips)"
        let total = Double (Int(price / Double (splitValue) * 100)) / 100.0
        totalDisplay.text = "$ \(total  + reducetips)"
    }
    @IBAction func sliderChanged(_ sender: UISlider)
    {
        if sender == foodSlider
        {
            foodScore = Int(sender.value)
        }
        else if sender == serviceSlider
        {
            serviceScore = Int(sender.value)
        }
        else if sender == tipsSlider
        {
            tipsPercent = Int(sender.value)
            calculateTips()
        }
        else
        {
            splitValue = Int(sender.value)
            calculateTips()
        }
    }
    func setSlider(min: Float, max: Float, value: Float, slider: UISlider)
    {
        slider.minimumValue = min
        slider.maximumValue = max
        slider.setValue(value, animated: true)
    }
}

//MARK: textField
extension TipsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let p = Double(textField.text!)
        {
            if(textField == priceInput)
            {
                 price = p
            }
            else
            {
                guestNumber = Int(p)
                splitSlider.maximumValue = Float(guestNumber)
            }
        }
        else
        {
            textField.text = ""
            textField.placeholder = "Positive Number only"
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



