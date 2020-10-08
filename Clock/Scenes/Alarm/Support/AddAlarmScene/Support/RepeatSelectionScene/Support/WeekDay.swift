//
//  WeekDay.swift
//  Clock
//
//  Created by Hardijs on 08/10/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

enum WeekDay: Int, CaseIterable {
    case monday = 0
    case tuesday = 1
    case wednesday = 2
    case thursday = 3
    case friday = 4
    case saturday = 5
    case sunday = 6
    
    func getDayNameString() -> String {
        switch self {
        case .monday:
            return "Monday"
        case .tuesday:
            return "Tuesday"
        case .wednesday:
            return "Wednesday"
        case .thursday:
            return "Thursday"
        case .friday:
            return "Friday"
        case .saturday:
            return "Saturday"
        case .sunday:
            return "Sunday"
        }
    }
}
