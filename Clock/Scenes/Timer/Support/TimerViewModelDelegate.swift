//
//  TimerViewModelDelegate.swift
//  Clock
//
//  Created by Hardijs on 18/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

protocol TimerViewModelDelegate: class {
    func timerStateChanged(state: TimerState)
    func timerPickedTimeChanged(time: TimeStruct)
    func countdownTimeChanged(timeString: String)
    func countdownTimerRanOut()
    func countdownTimerRanOutTimeChanged(timeString: String)
    func defaultTuneChanged(tune: Tune)
}
