//
//  AddAlarmViewModel.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

protocol AddAlarmViewModelDelegate: class {
    func pickedTimeChanged(time: TimeStruct)
}

class AddAlarmViewModel {
    
    weak var delegate: AddAlarmViewModelDelegate?
    
    private(set) var sceneTitle: String
    
    private(set) var pickedTime: TimeStruct {
        didSet {
            delegate?.pickedTimeChanged(time: pickedTime)
        }
    }
        
    private let alarmDAO = EntityDAO<AlarmEntity>()
    
    private(set) var editableAlarm: AlarmEntity?
    
    private(set) var inEditMode: Bool = false
    
    private(set) var snooze: Bool = false
    
    private(set) var label: String = "Alarm"
    
    init() {
        pickedTime = TimeStruct(hours: 0, minutes: 0, seconds: 0)
        sceneTitle = inEditMode ? "Edit Alarm" : "Add Alarm"
    }
    
    func setPickedTime(h: Int, m: Int) {
        pickedTime = TimeStruct(hours: h, minutes: m, seconds: 0)
    }
    
    private func addAlarm() {
        alarmDAO.createEntity { (new) in
            new.label = label
            new.timeString = "\(getPickerLabel(pickedTime.hours)):\(getPickerLabel(pickedTime.minutes))"
            new.bedtime = false
            new.enabled = true
            new.snooze = snooze
        }
    }
    
    func getPickerLabel(_ time: Int) -> String {
        return  time < 10 ? "0\(time)" : "\(time)"
    }
    
    func enterEditMode(alarm: AlarmEntity) {
        editableAlarm = alarm
        inEditMode = true
        sceneTitle = "Edit Alarm"
        let arr = alarm.timeString?.split(separator: ":").compactMap { Int(String($0)) }
        guard let h = arr?.first, let m = arr?.last, arr?.count == 2 else {
            // TODO: Warn user - edit failed
            return
        }
        setPickedTime(h: h, m: m)
        snooze = alarm.snooze
        if let labelDb = alarm.label {
            label = labelDb
        }
    }
    
    @objc func snoozeStateChanged(snoozeSwitch: UISwitch) {
        snooze = snoozeSwitch.isOn
    }
    
    func savePressed() {
        // Create new entry from selected values if not in edit mode, otherwise edit alarm
        if inEditMode {
             editAlarm()
        } else {
            addAlarm()
        }
    }
    
    private func editAlarm() {
        editableAlarm?.label = label
        editableAlarm?.snooze = snooze
        editableAlarm?.timeString = "\(getPickerLabel(pickedTime.hours)):\(getPickerLabel(pickedTime.minutes))"
        alarmDAO.save()
    }
    
    func deleteAlarm() {
        if let toBeDeleted = editableAlarm {
            alarmDAO.delete([toBeDeleted])
        }
    }
}
