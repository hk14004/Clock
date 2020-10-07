//
//  TuneCellViewModel.swift
//  Clock
//
//  Created by Hardijs on 28/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class TuneCellVM {
    
    weak var delegate: SelectionCellVMDelegate?
    
    let tune: Tune
    
    var isSelected: Bool {
        didSet {
            delegate?.stateChanged(selected: isSelected)
        }
    }
    
    init(tune: Tune, isDefault: Bool = false) {
        self.tune = tune
        self.isSelected = isDefault
    }
}
