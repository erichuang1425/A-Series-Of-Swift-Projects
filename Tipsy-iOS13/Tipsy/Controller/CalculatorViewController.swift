//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    var percentage = 0.1
    var calculatorBrain = CalculatorBrain()
    var split = 2.0
    var result = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        let label = sender.title(for: .normal)?.replacingOccurrences(of: "%", with: "")
        let number = Double(label ?? "0.0") ?? 0.0
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        percentage = (calculatorBrain.getpercentage(percentage: number))
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
        split = sender.value
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        let enteredValue = Double(billTextField.text ?? "0.0")
        result = calculatorBrain.resultValue(bill: enteredValue!, percentage: self.percentage, split: split)
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationRV = segue.destination as! ResultViewController
            destinationRV.result = String(result)
            destinationRV.percentageString = String(Int(percentage*100))
            destinationRV.splitString = String(Int(split))
            
        }
    }
}

