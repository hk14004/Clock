//
//  StopwatchCell.swift
//  Clock
//
//  Created by Hardijs on 01/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class StopwatchCell: UITableViewCell {
    
    private lazy var lapLabel: UILabel = {
        let label = UILabel()
        label.text = "LAP"
        label.textColor = .white
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        isUserInteractionEnabled = false
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        setupLapLabel()
        setupTimeLabel()
    }
    
    
    private func setupLapLabel() {
        contentView.addSubview(lapLabel)
        lapLabel.translatesAutoresizingMaskIntoConstraints = false
        lapLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        lapLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
    }
    
    private func setupTimeLabel() {
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
    }
}
