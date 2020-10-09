//
//  EditAlarmSnoozeCell.swift
//  Clock
//
//  Created by Hardijs on 19/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class EditAlarmSnoozeCell: UITableViewCell {
    
    private let toggle: UISwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: AddEditAlarmVM) {
        toggle.setOn(viewModel.editableAlarm?.snooze ?? false, animated: false)
        toggle.addTarget(viewModel, action: #selector(AddEditAlarmVM.setSnooze(snoozeSwitch:)), for: .valueChanged)
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = UIColor(named: "MenuItem")
        textLabel?.text = NSLocalizedString("Snooze", comment: "")
        textLabel?.textColor = .white
        contentView.addSubview(toggle)
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        toggle.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
    }
}
