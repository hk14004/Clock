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
    
    weak var delegate: TimerViewModelDelegate? {
        didSet {
            if delegate == nil { return }
            attach()
        }
    }
    
    private lazy var countdownTimer: Timer = Timer()
    
    private var startTime: Date?
    
    private var pausedTime: Date?
    
    private var endTime: Date? {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            delegate?.countdownTimerRanOutTimeChanged(timeString: dateFormatter.string(from: endTime!))
        }
    }
    
    private(set) var timerState: TimerState = .initalizing {
        didSet {
            if timerState == oldValue { return }
            previousTimerState = oldValue
            delegate?.timerStateChanged(state: timerState)
        }
    }
    
    private(set) var previousTimerState: TimerState = .initalizing
    
    private var pickedTime: TimeStruct = TimeStruct() {
        didSet {
            delegate?.timerPickedTimeChanged(time: pickedTime)
            verifyPicketTime()
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
    
    // Mark: Methods
    
    private func attach() {
        setSelectedTime(h: 0, m: 1, s: 1)
    }
    
    private func alarm() {
        delegate?.countdownTimerRanOut()
    }
    
    private func verifyPicketTime() {
        if pickedTime.getTotalTimeInSeconds() < 1 {
            timerState = .canNotStart
        } else {
            timerState = .canStart
        }
    }
    
    @objc private func decremenCountdownTimer(timer: Timer) {
        let secondsLeft: Int = Int(Date().distance(to: endTime!).rounded(.up))
        var t = TimeStruct()
        t.setTime(inSeconds: secondsLeft)
        countDownTimeLeft = t
    }
    
    private func startTimer() {
        timerState = .running
        countDownTimeLeft = pickedTime
        startTime = Date()
        endTime = Date(timeInterval: TimeInterval(exactly: Double(pickedTime.getTotalTimeInSeconds()))!, since: startTime!)
        countdownTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(decremenCountdownTimer), userInfo: nil, repeats: true)
    }
    
    private func resumeTimer() {
        timerState = .running
        let pauseInterval = pausedTime?.distance(to: Date())
        endTime?.addTimeInterval(pauseInterval!)
        countdownTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(decremenCountdownTimer), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        verifyPicketTime()
        countdownTimer.invalidate()
    }
    
    private func pauseTimer() {
        timerState = .paused
        pausedTime = Date()
        countdownTimer.invalidate()
    }
    
    func pressCancelButton() {
        guard timerState == .running || timerState == .paused else {
            return
        }
        stopTimer()
    }
    
    func pressStartButton() {
        guard timerState == .canStart else {
            return
        }
        startTimer()
    }
    
    func pressResumeButton() {
        guard timerState == .paused else {
            print("BUG: ViewController should not be able to call resume if not in paused state")
            return
        }
        resumeTimer()
    }
    
    func pressPauseButton() {
        guard timerState == .running else {
            print("BUG: ViewController should not be able to call pause if not in running state")
            return
        }
        pauseTimer()
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
