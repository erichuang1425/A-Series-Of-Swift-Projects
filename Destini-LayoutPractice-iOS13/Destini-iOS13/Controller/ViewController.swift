//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyLabel.text = "You see a fork in the road."
        choice1.setTitle("Take a left.", for: .normal)
        choice2.setTitle("Take a Right.", for: .normal)
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
    }
  
}

