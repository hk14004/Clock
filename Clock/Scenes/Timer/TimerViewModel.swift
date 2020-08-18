//
//  TimerViewModel.swift
//  Clock
//
//  Created by Hardijs on 18/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class TimerViewModel {
    
    weak var delegate: TimerViewModelDelegate?
    
    private(set) var timerState: TimerState = .notStarted {
        didSet {
            delegate?.timerStateChanged(state: timerState)
        }
    }
    
    private var pickedTime: PickedTime = PickedTime() {
        didSet {
            delegate?.timerPickedTimeChanged(time: pickedTime)
        }
    }
    
    // Init
    init(delegate: TimerViewModelDelegate) {
        self.delegate = delegate
        
        // TODO: Get from user defaults initial picked time
        setSelectedTime(h: 6, m: 6, s: 6)
    }
    
    func pressStartButton() {
        guard timerState == .notStarted else {
            print("BUG: ViewController should not be able to call start if not in notStarted state")
            return
        }
        timerState = .running
    }
    
    func pressCancelButton() {
        timerState = .notStarted
    }
    
    func pressResumeButton() {
        guard timerState == .paused else {
            print("BUG: ViewController should not be able to call resume if not in paused state")
            return
        }
        timerState = .running
    }
    
    func pressPauseButton() {
        guard timerState == .running else {
            print("BUG: ViewController should not be able to call pause if not in running state")
            return
        }
        timerState = .paused
    }
    
    func setSelectedTime(h: Int, m: Int, s: Int) {
        print("VM: Set picked time h:\(h) m:\(m), s:\(s)")
        pickedTime = PickedTime(pickedHours: h, pickedMinutes: m, pickedSeconds: s)
    }
}
