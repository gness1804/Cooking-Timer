//
//  ViewController.swift
//  Cooking Timer
//
//  Created by Graham Nessler on 6/30/18.
//  Copyright © 2018 Graham Nessler. All rights reserved.
//

// thanks to Jen Sipila's "Build a count down timer with Swift 3.0" tutorial, https://medium.com/ios-os-x-development/build-an-stopwatch-with-swift-3-0-c7040818a10f

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var seconds = 10
    var isTimerRunning = false
    var isPaused = false
    
    @IBAction func addNewTimer(_ sender: Any) {
        print("Added new timer.")
    }
    
    @IBOutlet weak var timeOutputLabel: UILabel!
    
    func convertTimeToString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let _seconds = Int(time) % 60
        
        return "\(hours): \(minutes): \(_seconds)"
    }
    
    func displayTime()  {
        timeOutputLabel.text = convertTimeToString(time: TimeInterval(seconds))
    }
    
    func timesUp()  {
        timeOutputLabel.text = "Time's Up!!"
    }
    
    func resetTime()  {
        timer.invalidate()
        seconds = 10
        displayTime()
        isTimerRunning = false
        isPaused = false
    }
    
    @objc func onTimeElapsed() {
        seconds -= 1
        displayTime()
        if seconds == 0 {
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
    }
    
    @IBAction func onResetPressed(_ sender: Any) {
        resetTime()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

