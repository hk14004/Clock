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
    
    let weekDay: WeekDay
    
    let itemName: String
    
    var isSelected: Bool {
        didSet {
            delegate?.stateChanged(selected: isSelected)
        }
    }
    
    init(weekDay: WeekDay, isSelected: Bool) {
        self.weekDay = weekDay
        self.isSelected = isSelected
        self.itemName = "Every " + weekDay.getDayNameString()
    }
}

