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
    var seconds = 60
    var isTimerRunning = false
    
    @IBOutlet weak var timeOutput: UILabel!
    
    @objc func onTimeElapsed() {
        seconds -= 1
        timeOutput.text = String(seconds)
        print(seconds)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.onTimeElapsed)), userInfo: nil, repeats: true)
    }
    
    @IBAction func onStopPressed(_ sender: Any) {
        print("Timer stopped.")
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

