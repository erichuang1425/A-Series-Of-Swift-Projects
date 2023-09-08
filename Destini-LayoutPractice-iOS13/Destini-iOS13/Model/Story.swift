//
//  Sotry.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct Story{
    let title:String
    let choice1:String
    let choice2:String
    let choice1Guide:Int
    let choice2Guide:Int
    init(title:String, choice1:String, choice2:String, choice1Guide:Int,choice2Guide:Int){
        self.title = title
        self.choice1 = choice1
        self.choice2 = choice2
        self.choice1Guide = choice1Guide
        self.choice2Guide = choice2Guide
    }
}
