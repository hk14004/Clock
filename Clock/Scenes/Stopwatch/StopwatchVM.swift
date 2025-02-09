//
//  StopwatchViewModel.swift
//  Clock
//
//  Created by Hardijs on 01/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

protocol StopwatchVMDelegate: class {
    func stopwatchStateChanged(state: StopwatchState)
    func stopwatchTimeChanged(timeString: String)
    func lapsChanged()
}

class StopwatchVM {
    
    weak var delegate: StopwatchVMDelegate?
    
    private(set) var stopwatchState: StopwatchState = .idle {
        didSet {
            delegate?.stopwatchStateChanged(state: stopwatchState)
        }
    }
    
    private var stopwatch: Timer?
    
    private var runningTime: TimeInterval?
    
    private var startTime: Date?
    
    private var stoppedTime: Date?
    
    private var stopwatchRunTime: TimeInterval = 0 {
        didSet {
            delegate?.stopwatchTimeChanged(timeString: StopwatchVM.createRunTimeString(distance: stopwatchRunTime))
            laps.first?.lapTime = stopwatchRunTime - lapOffsetTime
        }
    }
    
    private(set) var laps: [StopwatchCellVM] = [] {
        didSet {
            delegate?.lapsChanged()
        }
    }
    
    private var lapOffsetTime: TimeInterval = 0
    
    static func createRunTimeString(distance: TimeInterval) -> String {
        let minutes = Int((distance / 60).rounded(.down))
        let seconds = Int((distance - Double(minutes * 60) ).rounded(.down))
        let miliSecondsDouble: Double = distance - Double(minutes * 60) - Double(seconds)
        let miliInt: Int = Int(miliSecondsDouble * 10)
        
        var stringTime = ""
        if minutes < 10 {
            stringTime += "0\(minutes)"
        } else {
            stringTime += "\(minutes)"
        }
        
        stringTime += ":"
        
        if seconds < 10 {
            stringTime += "0\(seconds)"
        } else {
            stringTime += "\(seconds)"
        }
        stringTime += ","
        stringTime += "0\(miliInt)"
        
        return stringTime
    }
    
    @objc private func updateTime(timer: Timer) {
        guard let distance = startTime?.distance(to: Date()) else {
            return
        }
        
        stopwatchRunTime = distance
    }
    
    func startStopwatch() {
        if stopwatchState == .idle { // First start
            startTime = Date()
            addLap()
        } else { // Resume stopwatch
            let pausedTime = stoppedTime?.distance(to: Date())
            startTime = startTime?.addingTimeInterval(pausedTime!)
            stoppedTime = nil
        }
        
        stopwatch = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        RunLoop.current.add(stopwatch!, forMode: .tracking)
        stopwatchState = .running
    }
    
    func stopStopwatch() {
        stoppedTime = Date()
        stopwatch?.invalidate()
        stopwatchState = .stopped
    }
    
    func resetStopwatch() {
        stopwatch?.invalidate()
        startTime = nil
        stopwatchRunTime = 0
        stopwatchState = .idle
        lapOffsetTime = 0
        laps = []
    }
    
    func addLap() {
        lapOffsetTime += laps.first?.lapTime ?? 0
        laps.insert(StopwatchCellVM(), at: 0)
        setFastestAndSlowestLap()
    }
    
    private func setFastestAndSlowestLap() {
        var validLaps = laps
        validLaps.removeFirst()
        guard validLaps.count >= 2 else {
            return
        }
        
        let sortedLaps = validLaps.sorted(by: { (time1, time2) -> Bool in
            return time1.lapTime < time2.lapTime
        })
        
        sortedLaps.forEach { $0.lapState = .moderate }
    
        sortedLaps.first?.lapState = .fastest
        sortedLaps.last?.lapState = .slowest
    }
}
