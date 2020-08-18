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
    func timerPickedTimeChanged(time: PickedTime)
}
