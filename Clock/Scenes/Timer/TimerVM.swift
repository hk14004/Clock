//
//  TimerViewModel.swift
//  Clock
//
//  Created by Hardijs on 18/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation
import UserNotifications

class TimerVM: NSObject {
    
    // Mark: Properties
    
    weak var delegate: TimerVMDelegate? {
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
            }
        }
    }
    
    var defaultTune: Tune {
        get {
            let decoded  = UserDefaults.standard.object(forKey: DEFAULT_TUNE_KEY) as! Data
            return NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Tune
        }
    }
    
    private var alarmNotificationUUID = UUID().uuidString
    
    // Mark: Methods
    
    private func attach() {
        setSelectedTime(h: 0, m: 1, s: 1)
    }
    
    override init() {
        super.init()
        listenForDefaultTuneChange()
    }
    
    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: DEFAULT_TUNE_KEY)
    }
    
    private func listenForDefaultTuneChange() {
        UserDefaults.standard.addObserver(self, forKeyPath: DEFAULT_TUNE_KEY, options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        delegate?.defaultTuneChanged(tune: defaultTune)
    }

    
    private func scheduleAlarmNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("\(defaultTune.name).\(defaultTune.format)"))

        let time = TimeInterval(countDownTimeLeft.getTotalTimeInSeconds())

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)

        // Create the request
        let request = UNNotificationRequest(identifier: alarmNotificationUUID,
                    content: content, trigger: trigger)

        // Schedule the request
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request, withCompletionHandler: nil)
    }
    
    private func cancelNotificationAlarm() {
        if countDownTimeLeft.getTotalTimeInSeconds() > 0 {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarmNotificationUUID])
        }
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
        scheduleAlarmNotification()
    }
    
    private func resumeTimer() {
        timerState = .running
        let pauseInterval = pausedTime?.distance(to: Date())
        endTime?.addTimeInterval(pauseInterval!)
        countdownTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(decremenCountdownTimer), userInfo: nil, repeats: true)
        scheduleAlarmNotification()
    }
    
    private func stopTimer() {
        verifyPicketTime()
        countdownTimer.invalidate()
        cancelNotificationAlarm()
    }
    
    private func pauseTimer() {
        timerState = .paused
        pausedTime = Date()
        countdownTimer.invalidate()
        cancelNotificationAlarm()
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
        // Do not allow to set picked time after timer started. Possible start during picker animation.
        if  timerState == .running || timerState == .paused {
            delegate?.timerPickedTimeChanged(time: pickedTime)
            return
        }
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
