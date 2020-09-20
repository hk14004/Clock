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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: AddAlarmViewModel) {
        toggle.setOn(viewModel.editableAlarm?.snooze ?? false, animated: false)
        toggle.addTarget(viewModel, action: #selector(AddAlarmViewModel.snoozeStateChanged(snoozeSwitch:)), for: .valueChanged)
    }
}


