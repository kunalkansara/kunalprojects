//
//  CircularProgressBar.swift
//  ChatSDK
//
//  Created by Kansara, Kunal on 10/07/19.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit

protocol TimerDelegate {
    func timerCompleted()
}

class CircularProgressBar: UIView {
    
    //MARK: awakeFromNib
    var animateDuration : Int = 180
    var currentTime:Int = 0
    var timer : Timer!
    var timerDelegate : TimerDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        label.text = "10"
    }
    
    //MARK: Public
    public var lineWidth:CGFloat = 10 {
        didSet{
            foregroundLayer.lineWidth = lineWidth
            backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
        }
    }
    
    public var labelSize: CGFloat = 60 {
        didSet {
            label.font = UIFont.systemFont(ofSize: labelSize)
            label.sizeToFit()
            configLabel()
        }
    }
    
    public func setProgress(to progressConstant: Double) {
        
        var progress: Double {
            get {
                if progressConstant > 1 { return 1 }
                else if progressConstant < 0 { return 0 }
                else { return progressConstant }
            }
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.currentTime >= self.animateDuration {
                self.label.text = "\(self.animateDuration - Int(self.currentTime))"
                self.configLabel()
                timer.invalidate()
                self.timerDelegate.timerCompleted()
            } else {
                self.label.text = "\(self.animateDuration - self.currentTime)"
                
                let startAngle = (-CGFloat.pi/2)
                let endAngle = (2 * CGFloat(self.currentTime) * CGFloat.pi / 180) + startAngle
                let path = UIBezierPath(arcCenter: self.pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                self.foregroundLayer.path = path.cgPath
                self.foregroundLayer.strokeEnd = CGFloat(self.currentTime)
                
                self.setForegroundLayerColorForSafePercent()
                self.configLabel()
                self.currentTime += 1
            }
        }
        timer.fire()
        
    }
    
    //MARK: Private
    private var label = UILabel()
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var radius: CGFloat {
        get{
            if self.frame.width < self.frame.height { return (self.frame.width - lineWidth)/2 }
            else { return (self.frame.height - lineWidth)/2 }
        }
    }
    
    private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
    private func makeBar(){
        self.layer.sublayers = nil
        drawBackgroundLayer()
        drawForegroundLayer()
    }
    
    private func drawBackgroundLayer(){
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        self.backgroundLayer.path = path.cgPath
        self.backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 20/100)
        self.backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
        
    }
    
    private func drawForegroundLayer(){
        foregroundLayer.lineCap = CAShapeLayerLineCap.round
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeColor = UIColor.green.cgColor
        foregroundLayer.strokeEnd = 0
        
        self.layer.addSublayer(foregroundLayer)
        
    }
    
    private func configLabel(){
        label.sizeToFit()
        label.center = pathCenter
    }
    
    private func setForegroundLayerColorForSafePercent(){
        if currentTime >= self.animateDuration {
            self.foregroundLayer.strokeColor = UIColor.red.cgColor
        } else {
            self.foregroundLayer.strokeColor = UIColor.green.cgColor
        }
    }
    
    private func setupView() {
        makeBar()
        label.textColor = .white
        self.addSubview(label)
    }
    
    private var layoutDone : Bool = false
    override func layoutSublayers(of layer: CALayer) {
        if !layoutDone {
            let tempText = label.text
            setupView()
            label.text = tempText
            layoutDone = true
        }
    }
}
