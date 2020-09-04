//
//  StopwatchCellViewModel.swift
//  Clock
//
//  Created by Hardijs on 04/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class StopwatchCellViewModel {
        
    weak var delegate: StopwatchCellViewModelDelegate? {
        didSet {
            delegate?.stopwatchTimeChanged(timeString: StopwatchViewModel.createRunTimeString(distance: lapTime))
        }
    }
    
    var lapTime: TimeInterval = 0 {
        didSet {
            delegate?.stopwatchTimeChanged(timeString: StopwatchViewModel.createRunTimeString(distance: lapTime))
        }
    }
}

protocol StopwatchCellViewModelDelegate: class {
    func stopwatchTimeChanged(timeString: String)
}
