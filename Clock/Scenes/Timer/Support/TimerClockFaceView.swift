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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
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
    
    func setCountdownTime(timeString: String) {
        self.timeLeftLabel.text = timeString
    }
}
