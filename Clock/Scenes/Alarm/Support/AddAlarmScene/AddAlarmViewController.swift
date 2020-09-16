//
//  AddAlarmViewController.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AddAlarmViewController: UIViewController {
    
    private let addAlarmViewModel = AddAlarmViewModel()
    
    private let timePickerView = UIPickerView()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Secondary")
        setupNavigationBar()
        setupTimePicker()
    }
    
    private func setupTimePicker() {
        timePickerView.dataSource = self
        timePickerView.delegate = self
        
        view.addSubview(timePickerView)
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        timePickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        timePickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        timePickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    }
    
    private func setupNavigationBar() {
        title = "Add Alarm"
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        // Navigation items
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = save
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem = cancel
    }
    
    @objc func saveTapped() {
        // TODO: Perform save
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension AddAlarmViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return HOURS.count
        case 1:
            return MINUTES.count
        default:
            return 0
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // Find seperator and change color
        for view in pickerView.subviews where view.frame.size.height < 1 {
            view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        }
        
        // Create picker labels
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        
        func getPickerLabel(time: Int) -> String {
            return  time < 10 ? "0\(time)" : "\(time)"
        }
        
        switch component {
        case 0:
            label.text = "\(getPickerLabel(time: HOURS[row]))"
        case 1:
            label.text = "\(getPickerLabel(time: MINUTES[row]))"
        default:
            return label
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return timePickerView.frame.size.width / 3
    }
}
