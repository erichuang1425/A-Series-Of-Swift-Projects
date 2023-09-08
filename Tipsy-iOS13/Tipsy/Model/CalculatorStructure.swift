//
//  CalculatorStructure.swift
//  Tipsy
//
//  Created by Eric Huang on 4/30/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation
struct CalculatorBrain {

    func getpercentage(percentage:Double)->Double{
        let real = String(format:"%.1f", percentage*0.01)
        let doubleReal = Double(real) ?? 0.0
        return doubleReal
    }
    func resultValue(bill:Double, percentage:Double, split:Double)->Double{
        let calculation = bill*(1.0+percentage)/split
        let string = Double(String(format:"%.2f", calculation))
        return string ?? 0.0
    }
  
}
