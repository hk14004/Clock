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
        countdownCircle = TimerCircleCountdownView()
        addSubview(countdownCircle)
        
        countdownCircle.translatesAutoresizingMaskIntoConstraints = false
        countdownCircle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        countdownCircle.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 30).isActive = true
        countdownCircle.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        countdownCircle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func setCountdownTime(timeString: String) {
        self.timeLeftLabel.text = timeString
    }
}

class TimerCircleCountdownView: UIView {
    
    private var countdownTime: Int = 0
    
    private var animatedCountdownStrokeLayer: CAShapeLayer!
    
    func setCoundownTime(seconds: Int) {
        countdownTime = seconds
    }
    
    func createCountdownStrokeLayer(color: UIColor) -> CAShapeLayer {
        let path = UIBezierPath(arcCenter: center, radius: 170, startAngle: 3 * .pi/2, endAngle: -.pi/2, clockwise: false)
        let circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.strokeColor = color.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = 8
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
        animatedCountdownStrokeLayer.speed = 1.0
        animatedCountdownStrokeLayer.lineCap = .round
        animatedCountdownStrokeLayer.add(anim, forKey: "")
    }
    
    func pauseCountdownAnimation(){
        let pausedTime : CFTimeInterval = animatedCountdownStrokeLayer.convertTime(CACurrentMediaTime(), from: nil)
        animatedCountdownStrokeLayer.speed = 0.0
        animatedCountdownStrokeLayer.timeOffset = pausedTime
    }
    
    func resumeCountdownAnimation(){
        let pausedTime = animatedCountdownStrokeLayer.timeOffset
        animatedCountdownStrokeLayer.speed = 1.0
        animatedCountdownStrokeLayer.timeOffset = 0.0
        animatedCountdownStrokeLayer.beginTime = 0.0
        let timeSincePause = animatedCountdownStrokeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        animatedCountdownStrokeLayer.beginTime = timeSincePause
    }
    
    func cancelCountdownAnimation() {
        animatedCountdownStrokeLayer.removeAllAnimations()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(createCountdownStrokeLayer(color: .darkGray))
        animatedCountdownStrokeLayer = createCountdownStrokeLayer(color: .orange)
        layer.addSublayer(animatedCountdownStrokeLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
