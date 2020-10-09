//
//  AddAlarmViewModel.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

protocol AddEditAlarmVMDelegate: class {
    func pickedTimeChanged(time: TimeStruct)
    func alarmLabelChanged(text: String)
    func tuneChanged(tune: Tune)
    func repeatTimeChanged(text: String)
}

class AddEditAlarmVM {
    
    weak var delegate: AddEditAlarmVMDelegate?
    
    var sceneTitle: String {
        get {
            return inEditMode ? NSLocalizedString("Edit Alarm", comment: "") : NSLocalizedString("Add Alarm", comment: "")
        }
    }
    
    private(set) var pickedTime: TimeStruct {
        didSet {
            delegate?.pickedTimeChanged(time: pickedTime)
        }
    }
        
    private let alarmDAO = EntityDAO<AlarmEntity>()
    
    private(set) var editableAlarm: AlarmEntity?
    
    private(set) var inEditMode: Bool = false
    
    private(set) var snooze: Bool = false
    
    var label: String = NSLocalizedString("Alarm", comment: "") {
        didSet {
            delegate?.alarmLabelChanged(text: label)
        }
    }
    
    private(set) var tune: Tune = AlarmTunes.shared.getDefaultTune() {
        didSet {
            delegate?.tuneChanged(tune: tune)
        }
    }
    
    private(set) var selectedWeekDays: Set<WeekDay> = [] {
        didSet {
            delegate?.repeatTimeChanged(text: getRepeatTimeString())
        }
    }
    
    init() {
        pickedTime = TimeStruct(hours: 0, minutes: 0, seconds: 0)
    }
    
    func getRepeatTimeString() -> String {
        if selectedWeekDays.isEmpty { return NSLocalizedString("Never", comment: "") }
        if selectedWeekDays.count == WeekDay.allCases.count { return NSLocalizedString("Every day", comment: "") }
        var string = ""
        let sorted = selectedWeekDays.sorted { $0.rawValue < $1.rawValue }
        sorted.forEach { string += $0.getDayNameString().prefix(3) + " "}
        return string
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
            new.sound = tune
            let repeatData = try? JSONSerialization.data(withJSONObject: selectedWeekDays.compactMap { $0.rawValue }, options: [])
            new.alarmRepeat = repeatData
        }
    }
    
    func getPickerLabel(_ time: Int) -> String {
        return  time < 10 ? "0\(time)" : "\(time)"
    }
    
    func enterEditMode(alarm: AlarmEntity) {
        editableAlarm = alarm
        inEditMode = true
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
        tune = alarm.sound as! Tune
        if let alarmRepeatDays = alarm.alarmRepeat {
            let de = try? JSONSerialization.jsonObject(with: alarmRepeatDays, options: []) as? [Int]
            var set: Set<WeekDay> = []
            set.formUnion(de?.compactMap { WeekDay(rawValue: $0)} ?? [])
            selectedWeekDays = set
        }
    }
    
    @objc func setSnooze(snoozeSwitch: UISwitch) {
        snooze = snoozeSwitch.isOn
    }
    
    func savePressed() {
        // Create new entry from selected values if not in edit mode, otherwise edit alarm
        if inEditMode {
             editAlarmWithSelectedValues()
        } else {
            addAlarm()
        }
    }
    
    private func editAlarmWithSelectedValues() {
        editableAlarm?.label = label
        editableAlarm?.snooze = snooze
        editableAlarm?.timeString = "\(getPickerLabel(pickedTime.hours)):\(getPickerLabel(pickedTime.minutes))"
        editableAlarm?.sound = tune
        editableAlarm?.alarmRepeat = try? JSONSerialization.data(withJSONObject:
                                                                    selectedWeekDays.compactMap { $0.rawValue }, options: [])
        
        alarmDAO.save()
    }
    
    func deleteAlarm() {
        if let toBeDeleted = editableAlarm {
            alarmDAO.delete([toBeDeleted])
        }
    }
    
    func setTune(_ tune: Tune) {
        self.tune = tune
    }
    
    func setSelectedDays(_ selected: Set<WeekDay>) {
        selectedWeekDays = selected
    }
}
