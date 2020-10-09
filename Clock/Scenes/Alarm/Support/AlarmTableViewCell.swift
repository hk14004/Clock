//
//  AlarmTableViewCell.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    private(set) lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        contentView.addSubview(timeLabel)
        timeLabel.textColor = .white
        timeLabel.font = .systemFont(ofSize: 60, weight: .thin)
        return timeLabel
    }()
    
    private lazy var notesLabel: UILabel = {
        let notesLabel = UILabel()
        contentView.addSubview(notesLabel)
        notesLabel.textColor = .white
        notesLabel.font = .systemFont(ofSize: 15)
        return notesLabel
    }()
    
    private lazy var enabledToggle: UISwitch = {
        let toggle = UISwitch()
        contentView.addSubview(toggle)
        return toggle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: AlarmTableViewCellVM) {
        timeLabel.text = viewModel.timeString
        notesLabel.text = viewModel.notesString
        enabledToggle.removeTarget(nil, action: nil, for: UIControl.Event.valueChanged)
        enabledToggle.addTarget(viewModel, action: #selector(AlarmTableViewCellVM.switchChanged), for: UIControl.Event.valueChanged)
        setAlarm(enabled: viewModel.enabled)
    }
    
    private func setAlarm(enabled: Bool) {
        let textColor: UIColor = enabled ? .white : .gray
        timeLabel.textColor = textColor
        notesLabel.textColor = textColor
        enabledToggle.setOn(enabled, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        UIView.animate(withDuration: 0.3) {
            self.enabledToggle.isHidden = editing
            self.enabledToggle.alpha = editing ? 0 : 1
            self.layoutIfNeeded()
        }
    }
    
    private func setup() {
        backgroundColor = .clear
        editingAccessoryType = .disclosureIndicator
        selectedBackgroundView = {
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            return backgroundView
        }()
        layoutViews()
    }
    
    private func layoutViews() {
        // Toggle
        enabledToggle.translatesAutoresizingMaskIntoConstraints = false
        enabledToggle.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor).isActive = true
        enabledToggle.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        // Time label
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        
        // Notes label
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0).isActive = true
        notesLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        notesLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        notesLabel.numberOfLines = 0
        notesLabel.lineBreakMode = .byCharWrapping
        notesLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -30 - self.enabledToggle.frame.width).isActive = true
    }
}
