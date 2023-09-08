//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Eric Huang on 4/30/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    var result:String?
    var splitString:String?
    var percentageString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalLabel.text = result
        settingsLabel.text = "Split between \(splitString ?? "0") people, with \(percentageString ?? "0")% tip."
    }
    

    
    @IBAction func recalculatePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
