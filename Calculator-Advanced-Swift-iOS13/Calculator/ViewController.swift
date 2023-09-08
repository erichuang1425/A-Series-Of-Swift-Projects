//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
        @IBOutlet weak var displayLabel: UILabel!
    
        var storedSymbol = ""
        var previousNumber:Double = 0.0
        var storedValue:Double = 0.0
        private var isFinishedTyping:Bool = true
        private var shouldAddDecimalPoint: Bool = false
        private var displayValue :Double{
        
        
        get{
            guard let number = Double(displayLabel.text!) else{
                fatalError("Cannot convert display label into a Double.")
            }
            return number
        }
        set{
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        print(storedSymbol)
        isFinishedTyping = true
        
        if let calcMethod = sender.currentTitle{
            
            
            var isForCalculate: Bool{
                get{
                    switch calcMethod {
                    case "+", "-", "×", "÷", "=":
                        return true
                    default:
                        return false
                    }
                }
            }
            guard let result = calculate(symbol: calcMethod, isCalcMethod: isForCalculate, displayValue ) else {
                if calcMethod == "="{
                    fatalError("The calculation result is nil.")
                }else{
                return
                }
            }

            displayValue = result
        }
        
        
        
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle{
            
            if isFinishedTyping{
                if numValue == "."{
                    return
                }
                displayLabel.text = numValue
                isFinishedTyping = false
                
            }else{
             
                if displayLabel.text!.contains(".") && numValue == "."{
                    
                    return
                    
                }else{
                    displayLabel.text! += numValue
                }
                     
            }
            
            
        }
    
    }
    func setSymbol(symbol:String){
        storedSymbol = symbol
    }
    
    func calculate(symbol:String, isCalcMethod:Bool, _ numberDisplayed:Double) -> Double?{
        
            if isCalcMethod{
                switch symbol {
                
                case "+", "-", "×", "÷":
                    storedSymbol = symbol
                    previousNumber = numberDisplayed
                    return previousNumber
                case "=":
                    switch storedSymbol {
                        case "+":
                            storedValue = previousNumber + numberDisplayed
                                
                        case "-":
                                                               
                            storedValue = previousNumber - numberDisplayed
                                
                        case "×":
                            storedValue = previousNumber * numberDisplayed
                                
                                
                        case "÷":
                                                               
                            storedValue = previousNumber / numberDisplayed
                                    
                           
                        default:
                            return nil
                        }
                        print(storedValue)
                        return storedValue
                
                default:
                    
                    return nil
                    
                }
                
                
        }else{
            
           
            switch symbol {
                
            case "+/-":
                
                storedValue *= -1
            
            case "AC":
                
                storedValue = 0
                
            case "%":
                
                storedValue *= 0.01
                
            default:
                return nil
                
            }
        }
        return storedValue
    }
    
    

}




internal extension Double {
    func withCommas() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = NumberFormatter.Style.decimal
    numberFormatter.maximumFractionDigits = 8  // default is 3 decimals
    return numberFormatter.string(from: NSNumber(value: self)) ?? ""
  }
}

