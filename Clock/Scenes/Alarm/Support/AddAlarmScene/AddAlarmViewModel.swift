//
//  AddAlarmViewModel.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class AddAlarmViewModel {
    
    private var pickedTime: TimeStruct
    
    private let alarmDAO = EntityDAO<AlarmEntity>()
    
    init() {
        pickedTime = TimeStruct(hours: 0, minutes: 0, seconds: 0)
    }
    
    func setPickedTime(h: Int, m: Int) {
        print(h,m)
        pickedTime = TimeStruct(hours: h, minutes: m, seconds: 0)
    }
    
    func addAlarm() {
        alarmDAO.createEntity { (new) in
            new.label = "Alarm 1"
            new.timeString = "\(getPickerLabel(pickedTime.hours)):\(getPickerLabel(pickedTime.minutes))"
            new.bedtime = false
            new.enabled = true
        }
    }
    
    func getPickerLabel(_ time: Int) -> String {
        return  time < 10 ? "0\(time)" : "\(time)"
    }
}
