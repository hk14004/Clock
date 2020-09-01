//
//  StopwatchDigitalClockFaceCell.swift
//  Clock
//
//  Created by Hardijs on 31/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class StopwatchDigitalClockFaceCell: UICollectionViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "00:00,00"
        label.textColor = .white
        label.font = UIFont(name: "arial", size: 80)
        label.textAlignment = .center
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
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80).isActive = true
        
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true

    }
    
    func setTime(string: String) {
        label.text = string
    }
}

