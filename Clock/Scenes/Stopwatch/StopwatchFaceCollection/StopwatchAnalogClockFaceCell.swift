//
//  StopwatchAnalogClockFaceCell.swift
//  Clock
//
//  Created by Hardijs on 31/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class StopwatchAnalogClockFaceCell: UICollectionViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "ANALOG"
        label.textColor = .white
        label.font = UIFont(descriptor: label.font.fontDescriptor, size: 70)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
    }
    
    func setTime(string: String) {
        label.text = string
    }
}
