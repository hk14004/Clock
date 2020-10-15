//
//  TimerViewController.swift
//  Clock
//
//  Created by Hardijs on 15/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class TimerVC: UIViewController {
    
    // MARK: Properties
    
    private(set) var timerViewModel = TimerVM()
    
    private lazy var timePickerView: UIPickerView = {
        var view = UIPickerView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var timerClockFace: TimerClockFaceView = TimerClockFaceView()
    
    private lazy var startButton: UIButton = UIButton()
    
    private lazy var pauseButton: UIButton = UIButton()
    
    private lazy var resumeButton: UIButton = UIButton()
    
    private lazy var cancelButton: UIButton = UIButton()
    
    private lazy var changeTuneButton: TunePickerButton = TunePickerButton()
    
    private var scrollView = UIScrollView()
    
    private var contentView = UIView()
    
    // MARK: UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        self.view.backgroundColor = UIColor(named: "Secondary")
        timerViewModel.delegate = self
        setupTimePickerView()
        setupTimerButtons()
        setupTimerClockFace()
        setupChangeTuneButton()
    }
    
    // MARK: Setup methods
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.pin(to: view)
        scrollView.addSubview(contentView)
        contentView.pin(to: scrollView)
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func setupTimerButtons() {
        setupStartButton()
        setupPauseButton()
        setupResumeButton()
        setupCancelButton()
    }
    
    func setupTimerClockFace() {
        contentView.addSubview(timerClockFace)
        
        // Contraints
        timerClockFace.translatesAutoresizingMaskIntoConstraints = false
        timerClockFace.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        timerClockFace.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        timerClockFace.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        timerClockFace.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -30).isActive = true
    }
    
    private func addTimePickerViewTitles() {
        // Hours
        let hoursTitle = UILabel()
        hoursTitle.text = "hours"
        hoursTitle.textColor = .white
        hoursTitle.translatesAutoresizingMaskIntoConstraints = false
        let pickerSelectionContainer = timePickerView.subviews[1]
        pickerSelectionContainer.addSubview(hoursTitle)
        hoursTitle.centerYAnchor.constraint(equalTo: pickerSelectionContainer.centerYAnchor).isActive = true
        hoursTitle.widthAnchor.constraint(equalTo: pickerSelectionContainer.widthAnchor, multiplier: 0.5, constant: 1).isActive = true
        hoursTitle.textAlignment = .center

        // Minutes
        let minutesTitle = UILabel()
        minutesTitle.text = "min"
        minutesTitle.textColor = .white
        minutesTitle.translatesAutoresizingMaskIntoConstraints = false
        pickerSelectionContainer.addSubview(minutesTitle)
        minutesTitle.centerYAnchor.constraint(equalTo: pickerSelectionContainer.centerYAnchor).isActive = true
        minutesTitle.widthAnchor.constraint(equalTo: pickerSelectionContainer.widthAnchor, multiplier: 1, constant: 55).isActive = true
        minutesTitle.textAlignment = .center
        
        // Seconds
        let secondsTitle = UILabel()
        secondsTitle.text = "sec"
        secondsTitle.textColor = .white
        secondsTitle.translatesAutoresizingMaskIntoConstraints = false
        pickerSelectionContainer.addSubview(secondsTitle)
        secondsTitle.centerYAnchor.constraint(equalTo: pickerSelectionContainer.centerYAnchor).isActive = true
        secondsTitle.widthAnchor.constraint(equalTo: pickerSelectionContainer.widthAnchor, multiplier: 1, constant: -5).isActive = true
        secondsTitle.textAlignment = .right
    }
    
    private func setupTimePickerView() {
        contentView.addSubview(timePickerView)
        addTimePickerViewTitles()
               
        // Contraints
        timePickerView.pin(to: contentView, leading: 15)
        timePickerView.pin(to: contentView, trailing: -15)
        timePickerView.pin(to: contentView, top: 70)
    }
        
    func setupChangeTuneButton() {
        contentView.addSubview(changeTuneButton)
        
        changeTuneButton.setTitle(NSLocalizedString("When Timer Ends", comment: ""), for: .normal)
        changeTuneButton.setTitleColor(.white, for: .normal)
        changeTuneButton.layer.cornerRadius = 10
        changeTuneButton.backgroundColor = UIColor(named: "Primary")
        changeTuneButton.setBackgroundColor(color: .darkGray, forState: .highlighted)
        changeTuneButton.addTarget(self, action: #selector(showTunePickerPopoverView), for: .touchUpInside)
        changeTuneButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        changeTuneButton.contentHorizontalAlignment = .left
        changeTuneButton.setTuneName(timerViewModel.defaultTune.name)
        
        // Constraints
        changeTuneButton.translatesAutoresizingMaskIntoConstraints = false
        changeTuneButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        changeTuneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        changeTuneButton.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 30).isActive = true
        changeTuneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changeTuneButton.pin(to: contentView, bottom: -20)
    }
    
    func setupStartButton() {
        // Configure button
        startButton.setTitle(NSLocalizedString("Start", comment: ""), for: .normal)
        startButton.setTitleColor(.green, for: .normal)
        startButton.layer.cornerRadius = 38
        startButton.backgroundColor = UIColor(red: 26/255, green: 54/255, blue: 31/255, alpha: 1)
        startButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        startButton.addPaddedStroke(paddingColor: UIColor(named: "Secondary")!, strokeColor: startButton.backgroundColor!, borderWidth: 2)
        
        // Add button via stroke to main view
        contentView.addSubview(startButton)
        
        // Contraints
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 100).isActive = true
        startButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupResumeButton() {
        // Configure button
        resumeButton.setTitle(NSLocalizedString("Resume", comment: ""), for: .normal)
        resumeButton.setTitleColor(.green, for: .normal)
        resumeButton.layer.cornerRadius = 38
        resumeButton.backgroundColor = UIColor(red: 26/255, green: 54/255, blue: 31/255, alpha: 1)
        resumeButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)
        resumeButton.addTarget(self, action: #selector(resumeButtonPressed), for: .touchUpInside)
        resumeButton.addPaddedStroke(paddingColor: UIColor(named: "Secondary")!, strokeColor: resumeButton.backgroundColor!, borderWidth: 2)
        
        // Add button via stroke to main view
        contentView.addSubview(resumeButton)
        
        // Contraints
        resumeButton.translatesAutoresizingMaskIntoConstraints = false
        
        resumeButton.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 100).isActive = true
        resumeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        resumeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        resumeButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupPauseButton() {
        // Configure button
        pauseButton.setTitle(NSLocalizedString("Pause", comment: ""), for: .normal)
        pauseButton.setTitleColor(UIColor.systemOrange.withAlphaComponent(0.7), for: .normal)
        pauseButton.layer.cornerRadius = 38
        pauseButton.backgroundColor = UIColor(red: 41/255, green: 26/255, blue: 1/255, alpha: 1)
        pauseButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3), forState: .highlighted)
        pauseButton.addTarget(self, action: #selector(pauseButtonPressed), for: .touchUpInside)
        pauseButton.addPaddedStroke(paddingColor: UIColor(named: "Secondary")!, strokeColor: pauseButton.backgroundColor!, borderWidth: 2)
        
        // Add button via stroke to main view
        contentView.addSubview(pauseButton)
        
        // Contraints
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        pauseButton.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 100).isActive = true
        pauseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupCancelButton() {
        // Configure button
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        cancelButton.setTitleColor(.gray, for: .normal)
        cancelButton.layer.cornerRadius = 38
        cancelButton.backgroundColor = UIColor(named: "Primary")
        cancelButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.addPaddedStroke(paddingColor: UIColor(named: "Secondary")!, strokeColor: cancelButton.backgroundColor!, borderWidth: 2)
        
        // Add button via stroke to main view
        contentView.addSubview(cancelButton)
        
        // Contraints
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 100).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    // MARK: Handling user input
    
    @objc func pauseButtonPressed(sender: UIButton) {
        timerViewModel.pressPauseButton()
    }
    
    @objc func startButtonPressed(sender: UIButton!) {
        timerViewModel.pressStartButton()
    }
    
    @objc func cancelButtonPressed(sender: UIButton!) {
        timerViewModel.pressCancelButton()
    }
    
    @objc func resumeButtonPressed(sender: UIButton) {
        timerViewModel.pressResumeButton()
    }
    
    @objc func showTunePickerPopoverView() {
        let vc = TuneSelectionVC()
        let navVc = UINavigationController(rootViewController: vc)
        self.present(navVc, animated: true, completion: nil)
    }
    
    //MARK: MISC
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func fadeOutStartButton() {
        startButton.backgroundColor = UIColor(red: 26/255, green: 54/255, blue: 31/255, alpha: 0.5)
    }
    
    private func fadeInStartButton() {
        startButton.backgroundColor = UIColor(red: 26/255, green: 54/255, blue: 31/255, alpha: 1)
    }
}

extension TimerVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return HOURS.count
        case 1:
            return MINUTES.count
        case 2:
            return SECONDS.count
        default:
            return NSNotFound
        }
    }
}

extension TimerVC: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // Find seperator and change color
        for view in pickerView.subviews where view.frame.size.height < 1 {
            view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        }
        
        // Create picker labels
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.textColor = .white
        
        switch component {
        case 0:
            label.text = "\(HOURS[row])"
        case 1:
            label.text = "\(MINUTES[row])"
        case 2:
            label.text = "\(SECONDS[row])"
        default:
            return label
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            timerViewModel.setSelectedTime(h: row, m: pickerView.selectedRow(inComponent: 1), s: pickerView.selectedRow(inComponent:2))
        case 1:
            timerViewModel.setSelectedTime(h: pickerView.selectedRow(inComponent: 0), m: row, s: pickerView.selectedRow(inComponent:2))
        case 2:
            timerViewModel.setSelectedTime(h: pickerView.selectedRow(inComponent: 0), m: pickerView.selectedRow(inComponent: 1), s: row)
        default:
            print("BUG: Picker components out of range")
        }
    }
}

extension TimerVC: TimerVMDelegate {
    
    func defaultTuneChanged(tune: Tune) {
        changeTuneButton.setTuneName(tune.name)
    }
    
    func countdownTimerRanOutTimeChanged(timeString: String) {
        timerClockFace.setTimerStopTimeLabelText(timeString)
    }
    
    func countdownTimerRanOut() {
        
    }
    
    func countdownTimeChanged(timeString: String) {
        timerClockFace.setCountdownTime(timeString: timeString)
    }
    
    func timerPickedTimeChanged(time: TimeStruct) {
        timePickerView.selectRow(time.hours, inComponent: 0, animated: true)
        timePickerView.selectRow(time.minutes, inComponent: 1, animated: true)
        timePickerView.selectRow(time.seconds, inComponent: 2, animated: true)
        timerClockFace.countdownCircle.setCoundownTime(seconds: time.getTotalTimeInSeconds())
    }
    
    func timerStateChanged(state: TimerState) {
        // Change available buttons etc
        switch state {
        case .canStart:
            fadeInStartButton()
            startButton.isHidden = false
            pauseButton.isHidden = true
            resumeButton.isHidden = true
            UIView.animate(withDuration: 0.25) {
                self.timerClockFace.isHidden = true
                self.timerClockFace.alpha = 0
                self.timePickerView.isHidden = false
                self.timePickerView.alpha = 1
            }
            if timerViewModel.previousTimerState == .running || timerViewModel.previousTimerState == .paused {
                timerClockFace.countdownCircle.cancelCountdownAnimation()
            }
        case .paused:
            startButton.isHidden = true
            pauseButton.isHidden = true
            resumeButton.isHidden = false
            timerClockFace.isHidden = false
            timePickerView.isHidden = true
            timerClockFace.countdownCircle.pauseCountdownAnimation()
            timerClockFace.fadeOutRunOutTime()
        case .running:
            startButton.isHidden = true
            pauseButton.isHidden = false
            resumeButton.isHidden = true
            UIView.animate(withDuration: 0.25) {
                self.timerClockFace.isHidden = false
                self.timerClockFace.alpha = 1
                self.timePickerView.isHidden = true
                self.timePickerView.alpha = 0
            }
            timerClockFace.fadeInRunOutTime()
            if timerViewModel.previousTimerState == .paused {
                timerClockFace.countdownCircle.resumeCountdownAnimation()
            } else {
                timerClockFace.countdownCircle.startCountdownAnimation()
            }
        case .canNotStart:
            startButton.isHidden = false
            pauseButton.isHidden = true
            resumeButton.isHidden = true
            timerClockFace.isHidden = true
            timePickerView.isHidden = false
            fadeOutStartButton()
        case .initalizing:
            print("Timer is initializing")
        }
    }
}
