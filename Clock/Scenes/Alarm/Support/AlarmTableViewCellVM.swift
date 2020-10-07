//
//  AlarmTableViewCellViewModel.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AlarmTableViewCellVM {
    
    private(set) var timeString: String
    
    private(set) var notesString: String
    
    private(set) var enabled: Bool
    
    private let alarmDAO = EntityDAO<AlarmEntity>()
    
    private let alarmEntity: AlarmEntity
    
    init(alarm: AlarmEntity) {
        alarmEntity = alarm
        timeString = alarm.timeString ?? ""
        notesString = alarm.label ?? ""
        enabled = alarm.enabled
    }
    
    @objc func switchChanged(enabledSwitch: UISwitch) {
        enabled = enabledSwitch.isOn
        alarmEntity.enabled = enabled
        alarmDAO.save()
    }
}
