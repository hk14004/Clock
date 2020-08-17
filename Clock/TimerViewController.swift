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
        view.setValue(UIColor.white, forKeyPath: "textColor")
        view.backgroundColor = .clear
        return view
    }()
    
    private let minutesAndseconds: [Int] = makeIntArray(from: 0, to: 59)
    
    private let hours: [Int] = makeIntArray(from: 0, to: 23)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(named: "Secondary")
        setupTimePickerView()
    }
    
    func setupTimePickerView() {
        view.addSubview(timePickerView)

        // Contraints
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        timePickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        timePickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        timePickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(hours[row]) hours"
        case 1:
            return "\(minutesAndseconds[row]) min"
        case 2:
            return "\(minutesAndseconds[row]) sec"
        default:
            return nil
        }
    }
}

extension TimerViewController: UIPickerViewDelegate {}
