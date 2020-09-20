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
    
    private let tableView: UITableView = UITableView()
    
    private lazy var menuItems: [[UITableViewCell]] = {
        return [
            [createRepeatMenuCell(),
             createLabelMenuCell(),
             createSoundMenuCell(),
             createSnoozeCell()],
            [createDeleteMenuCell()]
        ]
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Secondary")
        addAlarmViewModel.delegate = self
        setupNavigationBar()
        setupTimePicker()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: timePickerView.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupTimePicker() {
        timePickerView.dataSource = self
        timePickerView.delegate = self
        timePickerView.selectRow(addAlarmViewModel.pickedTime.hours, inComponent: 0, animated: false)
        timePickerView.selectRow(addAlarmViewModel.pickedTime.minutes, inComponent: 1, animated: false)
        
        view.addSubview(timePickerView)
        timePickerView.translatesAutoresizingMaskIntoConstraints = false
        timePickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        timePickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        timePickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    }
    
    private func setupNavigationBar() {
        title = addAlarmViewModel.sceneTitle
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
        addAlarmViewModel.savePressed()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func prepareForEditing(alarm: AlarmEntity) {
        addAlarmViewModel.enterEditMode(alarm: alarm)
    }
    
    private func createSnoozeCell() -> EditAlarmSnoozeCell {
        let cell = EditAlarmSnoozeCell(style: .value1, reuseIdentifier: nil)
        cell.setup(with: addAlarmViewModel)
        return cell
    }
    
    private func createLabelMenuCell() -> AddEditAlarmMenuCell {
        let cell = AddEditAlarmMenuCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "Label"
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = addAlarmViewModel.label
        return cell
    }
    
    private func createRepeatMenuCell() -> AddEditAlarmMenuCell {
        let cell = AddEditAlarmMenuCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "Repeat"
        cell.detailTextLabel?.text = "Never"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    private func createSoundMenuCell() -> AddEditAlarmMenuCell {
        let cell = AddEditAlarmMenuCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "Sounds"
        cell.detailTextLabel?.text = "Radar"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    private func createDeleteMenuCell() -> AddEditAlarmMenuCell {
        let cell = AddEditAlarmMenuCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Delete Alarm"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
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
        
        switch component {
        case 0:
            label.text = "\(addAlarmViewModel.getPickerLabel(HOURS[row]))"
        case 1:
            label.text = "\(addAlarmViewModel.getPickerLabel(MINUTES[row]))"
        default:
            return label
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return timePickerView.frame.size.width / 3
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let h = HOURS[timePickerView.selectedRow(inComponent: 0)]
        let m = MINUTES[timePickerView.selectedRow(inComponent: 1)]
        addAlarmViewModel.setPickedTime(h: h, m: m)
    }
}

extension AddAlarmViewController: AddAlarmViewModelDelegate {
    func pickedTimeChanged(time: TimeStruct) {
        timePickerView.selectRow(time.hours, inComponent: 0, animated: false)
        timePickerView.selectRow(time.minutes, inComponent: 1, animated: false)
    }
}

extension AddAlarmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return addAlarmViewModel.inEditMode ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return menuItems[indexPath.section][indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            addAlarmViewModel.deleteAlarm()
            dismiss(animated: true, completion: nil)
        default:
            return
        }
    }
}
