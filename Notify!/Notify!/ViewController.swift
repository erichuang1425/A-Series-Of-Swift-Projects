//
//  ViewController.swift
//  Notify!
//
//  Created by Eric Huang on 12/3/20.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = Calendar.current

            let now = Date()
            let date = calendar.date(
                bySettingHour: 0,
                minute: 0,
                second: 2,
                of: now)!

            let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(runCode), userInfo: nil, repeats: false)

            RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @objc func runCode(){
        let notification = NSUserNotification()
        notification.title = "Hello"
        notification.subtitle = "You"
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.scheduleNotification(notification)
    }

}

