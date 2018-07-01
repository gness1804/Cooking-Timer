//
//  ViewController.swift
//  Cooking Timer
//
//  Created by Graham Nessler on 6/30/18.
//  Copyright © 2018 Graham Nessler. All rights reserved.
//

// thanks to Jen Sipila's "Build a count down timer with Swift 3.0" tutorial, https://medium.com/ios-os-x-development/build-an-stopwatch-with-swift-3-0-c7040818a10f
// and to https://learnappmaking.com/uialertcontroller-alerts-swift-how-to/
// and to this: https://medium.com/aviabird/the-one-with-userdefaults-aab2c2a7e170

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var seconds = 60
    var isTimerRunning = false
    var isPaused = false
    
    func restoreDefaultTime() {
        seconds = 60
        UserDefaults.standard.set(String(seconds), forKey: "cookingTimerTime")
        resetTime()
    }
    
    @IBAction func onDefaultButtonPress(_ sender: Any) {
        let alert = UIAlertController(title: "Restore Defaults?", message: "Do you want to restore the default time of 1 minute?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
       alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
        action in
        self.restoreDefaultTime()
       }))
        self.present(alert, animated: true)
    }
    
    func assignNewTime(time: String)  {
        var _time = 0
        if Int(time) != nil && Int(time)! > 0 {
            _time = Int(time)!
            seconds = _time * 60
            UserDefaults.standard.set(String(seconds), forKey: "cookingTimerTime")
            resetTime()
        } else {
            let alert = UIAlertController(title: "Oops!", message: "Error: Please enter a valid positive whole number.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func alertTimeInput() {
        let alert = UIAlertController(title: "How Many Minutes", message: "Please enter a number of minutes", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "The time..."
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            if alert.textFields?.first?.text != "" {
                self.assignNewTime(time: alert.textFields?.first?.text ?? "No number given.")
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func addNewTimer(_ sender: Any) {
        alertTimeInput()
    }
    
    @IBOutlet weak var timeOutputLabel: UILabel!
    
    func convertTimeToString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let _seconds = Int(time) % 60
        
        return "\(hours): \(minutes): \(_seconds)"
    }
    
    func notifyTimesUp() {
        let alert = UIAlertController(title: "Time's Up!", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.resetTime()
        }))
        self.present(alert, animated: true)
    }
    
    func displayTime()  {
        timeOutputLabel.text = convertTimeToString(time: TimeInterval(seconds))
    }
    
    func timesUp()  {
        timeOutputLabel.text = "Time's Up!!"
        notifyTimesUp()
    }
    
    func resetTime()  {
        timer.invalidate()
        if UserDefaults.standard.string(forKey: "cookingTimerTime") != nil {
            seconds = Int(UserDefaults.standard.string(forKey: "cookingTimerTime")!)!
        } else {
            seconds = 60
        }
        displayTime()
        isTimerRunning = false
        isPaused = false
    }
    
    @objc func onTimeElapsed() {
        seconds -= 1
        displayTime()
        if seconds < 1 {
            resetTime()
            timesUp()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.onTimeElapsed)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @IBAction func onPausePressed(_ sender: Any) {
        if !isPaused {
            timer.invalidate()
            isPaused = true
        } else {
            runTimer()
            isPaused = false
        }
    }
    
    @IBAction func onStartPressed(_ sender: Any) {
        if !isTimerRunning {
            runTimer()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "cookingTimerTime") != nil {
            let val = UserDefaults.standard.string(forKey: "cookingTimerTime")
            seconds = Int(val!)!
        } else {
            UserDefaults.standard.set("60", forKey: "cookingTimerTime")
        }
    }
    
    @IBAction func onResetPressed(_ sender: Any) {
        resetTime()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

