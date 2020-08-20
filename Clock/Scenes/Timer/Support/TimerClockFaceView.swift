//
//  TimerClockFace.swift
//  Clock
//
//  Created by Hardijs on 18/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class TimerClockFaceView: UIView {
    
    private var timeLeftLabel: UILabel = {
        var label = UILabel()
        label.text = "XX:XX:XX"
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = UIFont(name: "arial", size: 80)
        return label
    }()
    
    private(set) var countdownCircle: TimerCircleCountdownView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addCircle()
        addCountdownLabel()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addCountdownLabel() {
        addSubview(timeLeftLabel)
        
        timeLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLeftLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        timeLeftLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        timeLeftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        timeLeftLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    private func addCircle() {
        countdownCircle = TimerCircleCountdownView(frame: CGRect(x: 150, y: 150, width: frame.width, height: frame.height))
        addSubview(countdownCircle)
        
        countdownCircle.translatesAutoresizingMaskIntoConstraints = false
        countdownCircle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        countdownCircle.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        countdownCircle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        countdownCircle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func setCountdownTime(timeString: String) {
        self.timeLeftLabel.text = timeString
    }
}

class TimerCircleCountdownView: UIView {
    
    private var countdownTime: Int = 0
    
    private var countdownStrokeLayer: CAShapeLayer!
    
    func setCoundownTime(seconds: Int) {
        countdownTime = seconds
    }
    
    func createCountdownStrokeLayer() -> CAShapeLayer {
        let path = UIBezierPath(arcCenter: center, radius: 100, startAngle: 3 * .pi/2, endAngle: -.pi/2, clockwise: false)
        let circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.strokeColor = UIColor.orange.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = 5
        return circleLayer
    }
    
    private func createCountdownAnimation() -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "strokeStart")
        anim.toValue = 1
        anim.duration = Double(countdownTime)
        anim.fillMode = .forwards
        anim.isRemovedOnCompletion = false
        return anim
    }
    
    func startCountdownAnimation() {
        let anim = createCountdownAnimation()
        countdownStrokeLayer.speed = 1.0
        countdownStrokeLayer.lineCap = .round
        countdownStrokeLayer.add(anim, forKey: "")
    }
    
    func pauseCountdownAnimation(){
        let pausedTime : CFTimeInterval = countdownStrokeLayer.convertTime(CACurrentMediaTime(), from: nil)
        countdownStrokeLayer.speed = 0.0
        countdownStrokeLayer.timeOffset = pausedTime
    }
    
    func resumeCountdownAnimation(){
        let pausedTime = countdownStrokeLayer.timeOffset
        countdownStrokeLayer.speed = 1.0
        countdownStrokeLayer.timeOffset = 0.0
        countdownStrokeLayer.beginTime = 0.0
        let timeSincePause = countdownStrokeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        countdownStrokeLayer.beginTime = timeSincePause
    }
    
    func cancelCountdownAnimation() {
        countdownStrokeLayer.removeAllAnimations()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        countdownStrokeLayer = createCountdownStrokeLayer()
        layer.addSublayer(countdownStrokeLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
