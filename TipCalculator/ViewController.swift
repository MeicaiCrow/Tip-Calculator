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
    @IBOutlet weak var tipSelector: UISegmentedControl!
    @IBOutlet weak var roundSwitch: UISwitch!
    @IBOutlet weak var tipAmountField: UITextField!
    @IBOutlet weak var totalField: UITextField!
    
    @IBAction func calculateTip(_ sender: Any) {
        if let billAmount = Double(billAmountField.text!) {
            var tipPercentage = 0.0
            
            switch tipSelector.selectedSegmentIndex {
            case 0:
                tipPercentage = 0.10
            case 1:
                tipPercentage = 0.12
            case 2:
                tipPercentage = 0.15
            default:
                break
            }
            
            let roundedBillAmount = round(100 * billAmount) / 100
            let tipAmount = roundedBillAmount * tipPercentage
            let roundedTipAmount = round(100*tipAmount)/100
            let totalAmount = roundedBillAmount + roundedTipAmount
            
            if (!billAmountField.isEditing) {
                billAmountField.text = String(format: "%.2f", roundedBillAmount)
            }
            
            if roundSwitch.isOn{
                let tipAmount = ceil(totalAmount) - roundedBillAmount
                tipAmountField.text = String(format: "%.2f", tipAmount)
                totalField.text = String(format: "%.2f", ceil(totalAmount))
            } else{
                tipAmountField.text = String(format: "%.2f", roundedTipAmount)
                totalField.text = String(format: "%.2f", totalAmount)
            }
            
        } else {
            //show error
            billAmountField.text = ""
            tipAmountField.text = ""
            totalField.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

