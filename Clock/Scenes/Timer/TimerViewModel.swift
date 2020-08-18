//
//  TimerViewModel.swift
//  Clock
//
//  Created by Hardijs on 18/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class TimerViewModel {
    
    // Mark: Properties
        
    weak var delegate: TimerViewModelDelegate?
        
    private lazy var countdownTimer: Timer = Timer()

    private(set) var timerState: TimerState = .notStarted {
        didSet {
            delegate?.timerStateChanged(state: timerState)
        }
    }
    
    private var pickedTime: TimeStruct = TimeStruct() {
        didSet {
            delegate?.timerPickedTimeChanged(time: pickedTime)
        }
    }
    
    private var countDownTimeLeft: TimeStruct = TimeStruct() {
        didSet {
            delegate?.countdownTimeChanged(timeString: createTimeLeftLabel(h: countDownTimeLeft.hours,
                                                                           m: countDownTimeLeft.minutes,
                                                                           s: countDownTimeLeft.seconds))
            if countDownTimeLeft.getTotalTimeInSeconds() < 1 {
                stopTimer()
                alarm()
            }
        }
    }
    
    // Init
    init(delegate: TimerViewModelDelegate) {
        self.delegate = delegate
        
        // TODO: Get from user defaults initial picked time
        setSelectedTime(h: 1, m: 0, s: 1)
    }
    
    // Mark: Methods
    
    private func alarm() {
        delegate?.countdownTimerRanOut()
    }
    
    @objc private func decremenCountdownTimer(timer: Timer) {
        countDownTimeLeft.decrement(by: 1)
    }
    
    func pressStartButton() {
        guard timerState == .notStarted else {
            print("BUG: ViewController should not be able to call start if not in notStarted state")
            return
        }
        timerState = .running
        countDownTimeLeft = pickedTime
        startTimer()
    }
    
    private func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decremenCountdownTimer), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        countdownTimer.invalidate()
    }
    
    func pressCancelButton() {
        timerState = .notStarted
        stopTimer()
    }
    
    func pressResumeButton() {
        guard timerState == .paused else {
            print("BUG: ViewController should not be able to call resume if not in paused state")
            return
        }
        timerState = .running
        startTimer()
    }
    
    func pressPauseButton() {
        guard timerState == .running else {
            print("BUG: ViewController should not be able to call pause if not in running state")
            return
        }
        timerState = .paused
        stopTimer()
    }
    
    func setSelectedTime(h: Int, m: Int, s: Int) {
        print("VM: Set picked time h:\(h) m:\(m), s:\(s)")
        pickedTime = TimeStruct(hours: h, minutes: m, seconds: s)
    }
    
    private func createTimeLeftLabel(h: Int, m: Int, s: Int) -> String {
        var timeLeftString = ""
        
        // Process hours
        if h > 0 {
            timeLeftString += "\(h)"
            /// Add divider -> :
            timeLeftString += ":"
        }
        
        // Process minutes and seconds
        func processMinutesAndSeconds(n: Int) {
            if n > 0 {
                if n < 10 {
                    timeLeftString += "0\(n)"
                } else {
                    timeLeftString += "\(n)"
                }
            } else {
                timeLeftString += "00"
            }
        }
        
        processMinutesAndSeconds(n: m)
        
        /// Add divider -> :
        timeLeftString += ":"
        
        processMinutesAndSeconds(n: s)
        
        return timeLeftString
    }
}
