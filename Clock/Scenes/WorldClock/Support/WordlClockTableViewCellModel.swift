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
    
    var hideTime = false {
        didSet {
            wordlClockTableViewCell?.timeLabel.isHidden = hideTime
        }
    }
    
    var currentTime: Date = Date() {
        didSet {
            wordlClockTableViewCell?.setTime(currentTime, timezone: timezone)
        }
    }
    
   required init?(timeZoneId: String = "") {
        guard let timeZone = TimeZone(identifier: timeZoneId) else { return nil }
        self.timezone = timeZone
    }
}
