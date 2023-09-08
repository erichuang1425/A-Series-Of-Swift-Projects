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
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var storyBrain = StoryBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    func updateUI(){
        storyLabel.text = storyBrain.currentStoryTitle()
        choice1Button.setTitle(storyBrain.currentStoryChoice1(), for: .normal)
        choice2Button.setTitle(storyBrain.currentStoryChoice2(), for: .normal)
    }
    
    @IBAction func choiceMade(_ sender: UIButton) {
        
        let choice = (sender.titleLabel?.text!)
        let choice1 = storyBrain.currentStoryChoice1()
        if choice == choice1{
            storyBrain.nextStorychoice1Title()
        }else{
            storyBrain.nextStorychoice2Title()
        }
        updateUI()
    
        
    }
        
}
    

