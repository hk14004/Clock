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
        timeLabel.font = timeLabel.font.withSize(50)
        return timeLabel
    }()
    
    private lazy var notesLabel: UILabel = {
        let notesLabel = UILabel()
        contentView.addSubview(notesLabel)
        notesLabel.textColor = .white
        notesLabel.font = notesLabel.font.withSize(12)
        return notesLabel
    }()
    
    private lazy var enabledToggle: UISwitch = {
        let toggle = UISwitch()
        contentView.addSubview(toggle)
        return toggle
    }()
    
    private lazy var notesLabelTrailingToSafeArea = notesLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15)
    
    private lazy var notesLabelTrailingToToggle = notesLabel.trailingAnchor.constraint(equalTo: enabledToggle.leadingAnchor, constant: -15)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: AlarmTableViewCellViewModel) {
        timeLabel.text = viewModel.timeString
        notesLabel.text = viewModel.notesString
        enabledToggle.removeTarget(nil, action: nil, for: UIControl.Event.valueChanged)
        enabledToggle.addTarget(viewModel, action: #selector(AlarmTableViewCellViewModel.switchChanged), for: UIControl.Event.valueChanged)
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
        enabledToggle.isHidden = editing
        notesLabelTrailingToSafeArea.isActive = false
        notesLabelTrailingToToggle.isActive = false
        notesLabelTrailingToSafeArea.isActive = editing
        notesLabelTrailingToToggle.isActive = !editing
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            self.enabledToggle.alpha = editing ? 0 : 1
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
        // Time label
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        
        // Notes label
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0).isActive = false
        notesLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        notesLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        
        // Toggle
        enabledToggle.translatesAutoresizingMaskIntoConstraints = false
        enabledToggle.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        enabledToggle.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
    }
}
