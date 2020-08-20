//
//  TimerViewController.swift
//  Clock
//
//  Created by Hardijs on 15/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    // MARK: Properties
    
    private(set) var timerViewModel: TimerViewModel = TimerViewModel()
    
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
    
    // MARK: UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Secondary")
        timerViewModel.delegate = self
        setupTimePickerView()
        setupTimerButtons()
        setupTimerClockFace()
    }
    
    // MARK: Setup methods
    
    private func setupTimerButtons() {
        setupStartButton()
        setupPauseButton()
        setupResumeButton()
        setupCancelButton()
    }
    
    func setupTimerClockFace() {
        view.addSubview(timerClockFace)
        
        // Contraints
        timerClockFace.translatesAutoresizingMaskIntoConstraints = false
        timerClockFace.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        timerClockFace.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        timerClockFace.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        timerClockFace.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -30).isActive = true
    }
    
    func setupTimePickerView() {
        view.addSubview(timePickerView)
        
        // Contraints
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        timePickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        timePickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        timePickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
    }
    
    func setupStartButton() {
        // Configure button
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.green, for: .normal)
        startButton.layer.cornerRadius = 38
        startButton.backgroundColor = UIColor(red: 26/255, green: 54/255, blue: 31/255, alpha: 1)
        startButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        /// Add padded stroke
        //let strokeView = addPaddedStroke(button: startButton)
        
        // Add button via stroke to main view
        view.addSubview(startButton)
        
        // Contraints
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 100).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupResumeButton() {
        // Configure button
        resumeButton.setTitle("Resume", for: .normal)
        resumeButton.setTitleColor(.green, for: .normal)
        resumeButton.layer.cornerRadius = 38
        resumeButton.backgroundColor = UIColor(red: 26/255, green: 54/255, blue: 31/255, alpha: 1)
        resumeButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)
        resumeButton.addTarget(self, action: #selector(resumeButtonPressed), for: .touchUpInside)
        /// Add padded stroke
        //let strokeView = addPaddedStroke(button: startButton)
        
        // Add button via stroke to main view
        view.addSubview(resumeButton)
        
        // Contraints
        resumeButton.translatesAutoresizingMaskIntoConstraints = false
        
        resumeButton.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 100).isActive = true
        resumeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        resumeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        resumeButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupPauseButton() {
        // Configure button
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.setTitleColor(UIColor.systemOrange.withAlphaComponent(0.7), for: .normal)
        pauseButton.layer.cornerRadius = 38
        pauseButton.backgroundColor = UIColor(red: 41/255, green: 26/255, blue: 1/255, alpha: 1)
        pauseButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3), forState: .highlighted)
        pauseButton.addTarget(self, action: #selector(pauseButtonPressed), for: .touchUpInside)
        
        /// Add padded stroke
        //let strokeView = addPaddedStroke(button: pauseButton)
        
        // Add button via stroke to main view
        view.addSubview(pauseButton)
        
        // Contraints
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        pauseButton.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 100).isActive = true
        pauseButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupCancelButton() {
        // Configure button
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.gray, for: .normal)
        cancelButton.layer.cornerRadius = 38
        cancelButton.backgroundColor = UIColor(named: "Primary")
        cancelButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        /// Add padded stroke
        let strokeView = addPaddedStroke(button: cancelButton)
        
        // Add button via stroke to main view
        view.addSubview(strokeView)
        
        // Contraints
        strokeView.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 100).isActive = true
        strokeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        strokeView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        strokeView.heightAnchor.constraint(equalToConstant: 80).isActive = true
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
    
    //MARK: MISC
    
    private func addPaddedStroke(button: UIButton) -> UIView {
        /// Add padded stroke
        let strokeView = UIView()
        strokeView.backgroundColor = .clear
        strokeView.layer.borderColor = button.backgroundColor?.cgColor
        strokeView.layer.borderWidth = 2.0
        strokeView.layer.cornerRadius = 40
        /// Add start button as subview of stroke view
        strokeView.addSubview(button)
        
        // Contraints
        button.translatesAutoresizingMaskIntoConstraints = false
        strokeView.translatesAutoresizingMaskIntoConstraints = false
        /// Pin  start button to stroke view with a bit of padding
        button.topAnchor.constraint(equalTo: strokeView.topAnchor, constant: 3).isActive = true
        button.leadingAnchor.constraint(equalTo: strokeView.leadingAnchor, constant: 3).isActive = true
        button.trailingAnchor.constraint(equalTo: strokeView.trailingAnchor, constant: -3).isActive = true
        button.bottomAnchor.constraint(equalTo: strokeView.bottomAnchor, constant: -3).isActive = true
        
        return strokeView
    }
    
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

extension TimerViewController: UIPickerViewDataSource {
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

extension TimerViewController: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // Find seperator and change color
        for view in pickerView.subviews where view.frame.size.height < 1 {
            view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        }
        
        // Create picker labels
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        
        switch component {
        case 0:
            label.text = "\(HOURS[row]) hours"
        case 1:
            label.text = "\(MINUTES[row]) min"
        case 2:
            label.text = "\(SECONDS[row]) sec"
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

extension TimerViewController: TimerViewModelDelegate {
    func countdownTimerRanOut() {
        // TODO: WARN
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
            timerClockFace.isHidden = true
            timePickerView.isHidden = false
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
        case .running:
            startButton.isHidden = true
            pauseButton.isHidden = false
            resumeButton.isHidden = true
            timerClockFace.isHidden = false
            timePickerView.isHidden = true
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
