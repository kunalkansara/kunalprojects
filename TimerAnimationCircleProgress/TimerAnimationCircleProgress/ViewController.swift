//
//  ViewController.swift
//  TimerAnimationCircleProgress
//
//  Created by Kunal Kansara on 12/7/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let timerView = TimerProgressView.loadFromNib()
        timerView.showTimerView(view : self.view)
    }
}

