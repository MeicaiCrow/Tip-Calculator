//
//  ViewController.swift
//  TipCalculator
//
//  Created by Jinxin Wang on 2018-01-26.
//  Copyright © 2018 Jinxin Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var roundSwitch: UISwitch!
    @IBOutlet weak var roundedTipAmountField: UITextField!
    @IBOutlet weak var totalField: UITextField!
    @IBOutlet weak var tipAmountField: UITextField!
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        tipPercentageLabel.text = String(format:"%.0f", 100*tipSlider.value)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        if let billAmount = Double(billAmountField.text!) {
            let tipPercentage = Double(tipSlider.value)
            
            let decimalBillAmount = round(100 * billAmount) / 100
            let tipAmount = decimalBillAmount * tipPercentage
            let decimalTipAmount = round(100*tipAmount)/100
            
            let totalAmount = decimalBillAmount + decimalTipAmount
            
            if (!billAmountField.isEditing) {
                billAmountField.text = String(format: "%.2f", decimalBillAmount)
            }
            
            if roundSwitch.isOn{
                let roundedTotalAmount = floor(totalAmount)
                let roundedTip = roundedTotalAmount - decimalBillAmount
                
                tipAmountField.text = String(format: "%.2f", tipAmount)
                roundedTipAmountField.text = String(format:"%.2f", roundedTip)
                totalField.text = String(format: "%.2f", roundedTotalAmount)
            } else{
                tipAmountField.text = String(format: "%.2f", decimalTipAmount)
                totalField.text = String(format: "%.2f", totalAmount)
                roundedTipAmountField.text = ""
                roundedTipAmountField.isEnabled = false
            }
            
        } else {
            //show error
            billAmountField.text = ""
            tipAmountField.text = ""
            totalField.text = ""
            roundedTipAmountField.text = ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setStatusBarBackgroundColor(color: UIColor(red:0.21, green:0.48, blue:1.00, alpha:1.0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setStatusBarBackgroundColor(color : UIColor) {
        let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
        let statusBar : UIView = statusBarWindow.value(forKey: "statusBar") as! UIView
        /*
         if statusBar.responds(to:Selector("setBackgroundColor:")) {
         statusBar.backgroundColor = color
         }*/
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = color
        }
    }

}

