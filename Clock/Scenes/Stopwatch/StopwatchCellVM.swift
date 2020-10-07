//
//  StopwatchCellViewModel.swift
//  Clock
//
//  Created by Hardijs on 04/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class StopwatchCellVM {
        
    weak var delegate: StopwatchCellVMDelegate? {
        didSet {
            delegate?.stopwatchTimeChanged(timeString: StopwatchVM.createRunTimeString(distance: lapTime))
        }
    }
    
    var lapTime: TimeInterval = 0 {
        didSet {
            delegate?.stopwatchTimeChanged(timeString: StopwatchVM.createRunTimeString(distance: lapTime))
        }
    }
    
    var lapState: LapState = .moderate {
        didSet {
            delegate?.lapStateChanged(state: lapState)
        }
    }
}

protocol StopwatchCellVMDelegate: class {
    func stopwatchTimeChanged(timeString: String)
    func lapStateChanged(state: LapState)
}
