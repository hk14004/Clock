//
//  AlarmTableViewCellViewModel.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AlarmTableViewCellVM {
    
    private(set) var timeString: String = ""
    
    private(set) var notesString: String = ""
    
    private(set) var enabled: Bool = false
    
    private let alarmDAO = EntityDAO<AlarmEntity>()
    
    private let alarmEntity: AlarmEntity!
    
    required init(alarm: AlarmEntity) {
        alarmEntity = alarm
        timeString = alarm.timeString ?? ""
        notesString = createNotesText(from: alarm)
        enabled = alarm.enabled
    }
    
    @objc func switchChanged(enabledSwitch: UISwitch) {
        enabled = enabledSwitch.isOn
        alarmEntity.enabled = enabled
        alarmDAO.save()
    }
    
    private func createNotesText(from alarm: AlarmEntity) -> String {
        var returnedString = alarm.label ?? ""
        if let data = alarm.alarmRepeat, let repeatDays = (try? JSONSerialization.jsonObject(with: data, options: []) as? [Int])?.sorted().compactMap({ WeekDay.init(rawValue: $0)}) {
            if !repeatDays.isEmpty { returnedString += ", " }
            if repeatDays.count == WeekDay.allCases.count {
                returnedString += NSLocalizedString("Every day", comment: "").lowercased()
            } else {
                repeatDays.forEach { returnedString += $0.getDayNameString().prefix(3) + " "}
            }
        }
        return returnedString
    }
}
