//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var timeAlarm: UILabel!
    @IBOutlet weak var timeProgress: UIProgressView!
    var player: AVAudioPlayer!
    let eggTimes = ["Soft":300, "Medium": 420, "Hard":720]
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    @IBAction func hardnessSelect(_ sender: UIButton) {
        timer.invalidate()
        
        timeProgress.progress = 0
        secondPassed = 0
        let hardness = sender.currentTitle!
        timeAlarm.text = hardness
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        do{
            sleep(5)
        }
        player.stop()
        }
    @objc func updateCounter() {
        if secondPassed < totalTime {
            secondPassed += 1
            timeProgress.progress = Float(secondPassed)/Float(totalTime)
            print(timeProgress.progress)
        }else{
            timer.invalidate()
            timeAlarm.text = "DONE!"
            playSound()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {

        
    }

}
}
}
