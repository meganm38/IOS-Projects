//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class calculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip: Float = 0.1
    var splitNum: String = "2"
    var tipPct: String = "10%"
    var bill: Float?
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false;
        tenPctButton.isSelected = false;
        twentyPctButton.isSelected = false;
        sender.isSelected = true;
        
        tipPct = sender.currentTitle!
        
        switch tipPct {
        case "0%":
            tip = 0.0
        case "10%":
            tip = 0.1
        default:
            tip = 0.2
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNum = String(format: "%.0f", sender.value)
        splitNumberLabel.text = splitNum
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let billTotal = Float(billTextField.text ?? "0") ?? 0
        bill = billTotal * (1 + tip) / Float(splitNum)!
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let resultsView = segue.destination as! ResultsViewController
            resultsView.splitNumber = splitNum
            resultsView.tipPct = tipPct
            resultsView.bill = bill ?? 0.0
        }
    }
}

