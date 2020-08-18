//
//  TimerViewController.swift
//  Clock
//
//  Created by Hardijs on 15/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    private lazy var timePickerView: UIPickerView = {
        var view = UIPickerView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var startButton: UIButton = UIButton()
    
    private lazy var cancelButton: UIButton = UIButton()
    
    private let minutesAndseconds: [Int] = makeIntArray(from: 0, to: 59)
    
    private let hours: [Int] = makeIntArray(from: 0, to: 23)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(named: "Secondary")
        setupTimePickerView()
        setupStartButton()
        setupCancelButton()
    }
    
    func setupTimePickerView() {
        view.addSubview(timePickerView)
        
        // Contraints
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        timePickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        timePickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        timePickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
    }
    
    @objc func startButtonPressed(sender: UIButton!) {
        print("Start button tapped")
    }
    
    @objc func cancelButtonPressed(sender: UIButton!) {
        print("Cancel button tapped")
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
        let strokeView = addPaddedStroke(button: startButton)
        
        // Add button via stroke to main view
        view.addSubview(strokeView)
        
        // Contraints
        strokeView.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 100).isActive = true
        strokeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        strokeView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        strokeView.heightAnchor.constraint(equalToConstant: 80).isActive = true
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
}

extension TimerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1,2:
            return minutesAndseconds.count
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
        
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        
        switch component {
        case 0:
            label.text = "\(hours[row]) hours"
        case 1:
            label.text = "\(minutesAndseconds[row]) min"
        case 2:
            label.text = "\(minutesAndseconds[row]) sec"
        default:
            return label
        }
        
        return label
    }
}
