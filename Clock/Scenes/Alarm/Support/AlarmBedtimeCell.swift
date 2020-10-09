//
//  AlarmBedtimeCell.swift
//  Clock
//
//  Created by Hardijs on 02/10/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AlarmBedtimeCell: UITableViewCell {
    
    private(set) lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        contentView.addSubview(timeLabel)
        timeLabel.textColor = .gray
        timeLabel.font = timeLabel.font.withSize(45)
        return timeLabel
    }()
    
    private lazy var notesLabel: UILabel = {
        let notesLabel = UILabel()
        contentView.addSubview(notesLabel)
        notesLabel.textColor = .gray
        notesLabel.font = notesLabel.font.withSize(12)
        return notesLabel
    }()
    
    private lazy var changeButton: UIButton = {
        let changeButton = UIButton()
        contentView.addSubview(changeButton)
        changeButton.setTitle(NSLocalizedString("CHANGE", comment: ""), for: .normal)
        changeButton.titleLabel?.lineBreakMode = .byTruncatingTail
        changeButton.setTitleColor(.orange, for: .normal)
        changeButton.backgroundColor = UIColor(named: "Primary")
        changeButton.layer.masksToBounds = true
        changeButton.layer.cornerRadius = 15
        changeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        changeButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        //changeButton.isHidden = true
        return changeButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .clear
        
        // Change button
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        changeButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        changeButton.widthAnchor.constraint(greaterThanOrEqualTo: contentView.widthAnchor, multiplier: 0).isActive = true
        changeButton.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        
        // Time label
        timeLabel.text = NSLocalizedString("No Alarm", comment: "")
        timeLabel.numberOfLines = 0
        timeLabel.lineBreakMode = .byWordWrapping
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: changeButton.leadingAnchor, constant: -15).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        
        // Notes label
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0).isActive = false
        notesLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        notesLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
    
        layoutIfNeeded()
    }
}
