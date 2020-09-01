//
//  StopwatchViewModel.swift
//  Clock
//
//  Created by Hardijs on 01/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

protocol StopwatchViewModelDelegate: class {
    func stopwatchStateChanged(state: StopwatchState)
}

class StopwatchViewModel {
    
    weak var delegate: StopwatchViewModelDelegate?
    
    private(set) var stopwatchState: StopwatchState = .idle {
        didSet {
            delegate?.stopwatchStateChanged(state: stopwatchState)
        }
    }
        
    func startStopwatch() {
        // TODO: Probably resume handlng here too
        stopwatchState = .running
    }
    
    func stopStopwatch() {
        stopwatchState = .stopped
    }
    
    func resetStopwatch() {
        stopwatchState = .idle
    }
    
    func addLap() {
        guard stopwatchState == .running else {
            return
        }
        print("VM: adding lap")
    }
}


