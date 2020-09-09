//
//  WordlClockTableViewModel.swift
//  Clock
//
//  Created by Hardijs on 09/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//


import Foundation

class WordlClockTableViewCellModel {
    
    weak var wordlClockTableViewCell: WordlClockTableViewCell?
    
    var timezone: TimeZone {
        didSet {
            wordlClockTableViewCell?.setTime(currentTime, timezone: timezone)
        }
    }
    
    var isEditing: Bool {
        didSet {
            hideTime = isEditing
        }
    }
    
    var hideTime: Bool {
        didSet {
            wordlClockTableViewCell?.timeLabel.isHidden = hideTime
        }
    }
    
    var currentTime: Date = Date() {
        didSet {
            wordlClockTableViewCell?.setTime(currentTime, timezone: timezone)
        }
    }
    
    required init?(timeZoneId: String = "", isEditing: Bool) {
        guard let timeZone = TimeZone(identifier: timeZoneId) else { return nil }
        self.timezone = timeZone
        self.hideTime = isEditing
        self.isEditing = isEditing
    }
}
