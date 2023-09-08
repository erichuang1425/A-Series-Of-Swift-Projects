//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Eric Huang on 4/24/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
import UIKit
struct CalculatorBrain {
    
    var bmi:BMI?
    
    func getAdvice()->String{
        return bmi?.advice ?? "No adivce"
    }
    func getColor()->UIColor{
        return bmi?.color ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    func getBMIvalue()->String{
        let bmiValue = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiValue
    }
    mutating func calculateBMI(height:Float, weight:Float){
        let bmivalue = weight/pow(height, 2)
        switch bmivalue{
        case ..<18.5:
            bmi = BMI(value: bmivalue, advice: "Eat more ", color:#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        case 18.5...24.9:
            bmi = BMI(value: bmivalue, advice: "Enough", color:#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        case 24.9...:
            bmi = BMI(value: bmivalue, advice: "Eat too much", color:#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        default:
            break
            
        }

    }
    
}
