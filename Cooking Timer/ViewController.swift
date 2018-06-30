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
    
    
    @IBAction func onStopPressed(_ sender: Any) {
        timer.invalidate()
        print("Timer stopped.")
    }
    
    @objc func handleTimer() {
        print("Timer ran.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.handleTimer), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

