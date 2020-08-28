//
//  TuneCellViewModel.swift
//  Clock
//
//  Created by Hardijs on 28/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

protocol TuneCellViewModelDelegate: class {
    func defaultValueChanged(isDefault: Bool)
}

class TuneCellViewModel {
    
    weak var delegate: TuneCellViewModelDelegate?
    
    let tune: Tune
    
    var isdefault: Bool {
        didSet {
            delegate?.defaultValueChanged(isDefault: isdefault)
        }
    }
    
    init(tune: Tune, isDefault: Bool = false) {
        self.tune = tune
        self.isdefault = isDefault
    }
}
