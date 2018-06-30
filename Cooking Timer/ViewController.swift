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
    
    @IBAction func addNewTimer(_ sender: Any) {
        print("Added new timer.")
    }
    
    @IBOutlet weak var timeOutputLabel: UILabel!
    
    func timesUp()  {
        timeOutputLabel.text = "Time's Up!!"
    }
    
    func resetTime()  {
        timer.invalidate()
        seconds = 10
    }
    
    @objc func onTimeElapsed() {
        seconds -= 1
        timeOutputLabel.text = String(seconds)
        if seconds == 0 {
            timesUp()
            resetTime()
        }
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.onTimeElapsed)), userInfo: nil, repeats: true)
    }
    
    @IBAction func onPausePressed(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func onStartPressed(_ sender: Any) {
        runTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

