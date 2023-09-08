//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import Swifter
class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let swifter = Swifter(consumerKey: "r4dCxmwzriIVI4wQC5nXFHOGu", consumerSecret: "3Mh46mFJl3oCUHhVzaVWZmE320fqQjrHh3V1mH0n9vre4h5ooD")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func predictPressed(_ sender: Any) {
        
        if let TweetTag = textField.text{
            swifter.searchTweet(using: TweetTag, lang: "en", count:100,tweetMode: .extended, success:{ (results, metadata) in
                print(results)
            }) { (error) in
                print("Error occurred during result requesting: ",error)
            }
        }
    }
    
}

