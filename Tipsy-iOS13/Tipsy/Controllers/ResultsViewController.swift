//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Megan Ma on 2022-05-16.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var splitNumber: String?
    var tipPct: String?
    var bill: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = String(format: "%.2f", bill ?? "0")
        settingsLabel.text = "Split between \(splitNumber ?? "2") people, with \(tipPct ?? "10%") tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    
}
