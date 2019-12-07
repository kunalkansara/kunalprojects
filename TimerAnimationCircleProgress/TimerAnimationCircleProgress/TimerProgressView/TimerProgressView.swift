//
//  TimerProgressView.swift
//  ChatSDK
//
//  Created by Kansara, Kunal on 10/07/19.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

class TimerProgressView: UIView, TimerDelegate {
    
    @IBOutlet weak var viewWhiteBG: CircularProgressBar!
    
    var circleLayer: CAShapeLayer!
        
    static func loadFromNib() -> TimerProgressView {
        let bundle = Bundle(for: TimerProgressView.self)
        return bundle.loadNibNamed("TimerProgressView", owner: self, options: nil)![0] as! TimerProgressView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    internal func setUpUI(){
        self.frame = UIScreen.main.bounds
        viewWhiteBG.timerDelegate = self
        viewWhiteBG.labelSize = 60
        viewWhiteBG.setProgress(to: 1)
    }
    
    internal func showTimerView(view : UIView) {
        self.setUpUI()
        self.frame = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.size.width, height: view.bounds.size.height)
        view.addSubview(self)
        self.alpha = 1.0
    }
    
    @objc internal func dismissView() {
        self.hideScreen()
    }
    
    internal func hideScreen(){
        
        viewWhiteBG.timer.invalidate()
        viewWhiteBG.timer = nil
        
        DispatchQueue.main.async(execute: { ()-> Void in
            self.removeFromSuperview()
        })
    }
    
    func timerCompleted() {
        DispatchQueue.main.async(execute: { ()-> Void in
            self.removeFromSuperview()
        })
    }
}
