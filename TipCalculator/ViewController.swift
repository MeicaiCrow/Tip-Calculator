//
//  ViewController.swift
//  TipCalculator
//
//  Created by Jinxin Wang on 2018-01-26.
//  Copyright © 2018 Jinxin Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var roundSwitch: UISwitch!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var roundedPercentageLabel: UILabel!
    @IBOutlet weak var roundedTipAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var roundedStackView: UIStackView!
    @IBOutlet weak var roundedPercentageStackView: UIStackView!
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        tipPercentageLabel.text = String(format:"%.0f", 100*tipSlider.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain,target: self,action: #selector(doneButtonAction))
        let clear : UIBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain,target: self,action: #selector(clearButtonAction))
        var items:[UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(clear)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.billAmountField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.billAmountField.resignFirstResponder()
    }
    
    @objc func clearButtonAction() {
        self.billAmountField.text = ""
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        if roundSwitch.isOn {
            roundedStackView.isHidden = false
            roundedPercentageStackView.isHidden = false
        } else {
            roundedStackView.isHidden = true
            roundedPercentageStackView.isHidden = true
        }
        self.view.endEditing(false)
        if let billAmount = Double(billAmountField.text!) {
            let tipPercentage = Double(Double(tipPercentageLabel.text!)!/100.0)
            let decimalBillAmount = round(100 * billAmount) / 100
            let tipAmount = decimalBillAmount * tipPercentage
            let decimalTipAmount = round(100*tipAmount)/100
            
            let totalAmount = decimalBillAmount + decimalTipAmount
            
            if (!billAmountField.isEditing) {
                billAmountField.text = String(format: "%.2f", decimalBillAmount)
            }
            
            if roundSwitch.isOn{
                var roundedTotalAmount = 0.0
                if floor(totalAmount) <= billAmount{
                    roundedTotalAmount = ceil(totalAmount)
                } else{
                    roundedTotalAmount = floor(totalAmount)
                }
                
                let roundedTip = roundedTotalAmount - decimalBillAmount
                tipAmountLabel.text = String(format: "%.2f", tipAmount)
                roundedTipAmountLabel.text = String(format:"%.2f", roundedTip)
                totalLabel.text = String(format: "%.2f", roundedTotalAmount)
                roundedPercentageLabel.text = String(format:"%.1f%%", 100 * roundedTip/billAmount)
            } else{
                tipAmountLabel.text = String(format: "%.2f", decimalTipAmount)
                totalLabel.text = String(format: "%.2f", totalAmount)
                roundedTipAmountLabel.text = ""
                roundedPercentageLabel.text = ""
            }
            
        } else {
            //show error
            billAmountField.text = ""
            tipAmountLabel.text = ""
            totalLabel.text = ""
            roundedTipAmountLabel.text = ""
            roundedPercentageLabel.text = ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
}

