//
//  Sotry.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct Story {
    var title:String
    var choice1:String
    var choice1destination:Int
    var choice2:String
    var choice2destination:Int
    init(title:String, choice1:String, choice1destination:Int, choice2:String,  choice2destination:Int){
        self.title = title
        self.choice1 = choice1
        self.choice1destination = choice1destination
        self.choice2 = choice2
        self.choice2destination = choice2destination
    }
}
