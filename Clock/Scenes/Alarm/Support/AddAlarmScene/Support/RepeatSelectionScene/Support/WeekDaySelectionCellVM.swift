//
//  WeekDaySelectionCellVM.swift
//  Clock
//
//  Created by Hardijs on 08/10/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class WeekDaySelectionCellVM {
    
    weak var delegate: SelectionCellVMDelegate?
    
    private(set) var weekDay: WeekDay = .monday
    
    private(set) var itemName: String = ""
    
    var isSelected: Bool {
        didSet {
            delegate?.stateChanged(selected: isSelected)
        }
    }
    
    required init(weekDay: WeekDay, isSelected: Bool) {
        self.weekDay = weekDay
        self.isSelected = isSelected
        self.itemName = createItemName(from: weekDay)
    }
    
    private func createItemName(from weekDay: WeekDay) -> String {
        switch weekDay {
        case .monday:
            return NSLocalizedString("Every Monday", comment: "")
        case .tuesday:
            return NSLocalizedString("Every Tuesday", comment: "")
        case .wednesday:
            return NSLocalizedString("Every Wednesday", comment: "")
        case .thursday:
            return NSLocalizedString("Every Thrusrday", comment: "")
        case .friday:
            return NSLocalizedString("Every Friday", comment: "")
        case .saturday:
            return NSLocalizedString("Every Saturday", comment: "")
        case .sunday:
            return NSLocalizedString("Every Sunday", comment: "")
        }
    }
}

