//
//  AlarmTableViewCellViewModel.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class AlarmTableViewCellViewModel {
    
    private(set) var timeString: String
    
    private(set) var notesString: String
    
    private(set) var enabled: Bool
    
    init(alarm: AlarmEntity) {
        timeString = alarm.timeString ?? ""
        notesString = alarm.label ?? ""
        enabled = alarm.enabled
    }
}
