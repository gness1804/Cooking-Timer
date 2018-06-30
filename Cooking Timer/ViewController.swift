//
//  ViewController.swift
//  Cooking Timer
//
//  Created by Graham Nessler on 6/30/18.
//  Copyright © 2018 Graham Nessler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var seconds = 60
    
    @IBOutlet weak var timeOutput: UILabel!
    
    @IBAction func onStopPressed(_ sender: Any) {
        timer.invalidate()
        print("Timer stopped.")
    }
    
    @objc func onTimeElapsed() {
        seconds -= 1
        timeOutput.text = String(seconds)
        print(seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.onTimeElapsed), userInfo: nil, repeats: true)
        
        timeOutput.text = String(seconds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

