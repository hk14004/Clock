//
//  AddEditAlarmVC.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AddEditAlarmVC: UIViewController {
    
    private let addAlarmViewModel = AddEditAlarmVM()
    
    private let timePickerView = UIPickerView()
    
    private let tableView: UITableView = UITableView()
    
    private lazy var tableViewMenuItems: [[TableViewMenuItem]] = createTableViewMenuItems()
    
    private lazy var repeatMenuCell = createRepeatMenuCell()

    private lazy var labelMenuCell = createLabelMenuCell()
    
    private lazy var soundMenuCell = createSoundMenuCell()
    
    private lazy var snoozeMenuCell = createSnoozeCell()
    
    private lazy var deleteMenuCell = createDeleteMenuCell()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Primary")
        addAlarmViewModel.delegate = self
        setupNavigationBar()
        setupTimePicker()
        setupTableView()
    }
    
    private func createTableViewMenuItems() -> [[TableViewMenuItem]] {
        let repeatItem = TableViewMenuItem(tableViewCell: repeatMenuCell) {
            self.segueToEditRepeatView()
        }
        
        let labelItem = TableViewMenuItem(tableViewCell: labelMenuCell) {
            self.segueToEditLabelView()
        }
        
        let soundItem = TableViewMenuItem(tableViewCell: soundMenuCell) {
            self.segueToAlarmTuneSelectionView()
        }
        
        let snoozeItem = TableViewMenuItem(tableViewCell: snoozeMenuCell) {
           print("Snooze ACTION")
        }
        
        let deleteItem = TableViewMenuItem(tableViewCell: createDeleteMenuCell()) {
            self.addAlarmViewModel.deleteAlarm()
            self.dismiss(animated: true, completion: nil)
        }
        
        return [[repeatItem, labelItem, soundItem, snoozeItem],[deleteItem]]
    }
    
    private func segueToEditLabelView() {
        let editVC = EditLabelVC()
        editVC.editLabel(addAlarmViewModel.label) { edited in
            self.addAlarmViewModel.label = edited
        }
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    private func segueToEditRepeatView() {
        let repeatVC = RepeatSelectionVC()
        repeatVC.setPreselectedDays(preSelected: addAlarmViewModel.selectedWeekDays)
        repeatVC.onSelectionCompleted = { selected in
            self.addAlarmViewModel.setSelectedDays(selected)
        }
        navigationController?.pushViewController(repeatVC, animated: true)
    }
    
    private func segueToAlarmTuneSelectionView() {
        let alarmVC = AlarmTuneSelectionVC()
        alarmVC.selectTune(addAlarmViewModel.tune)
        alarmVC.onTuneSelected = { tune in
            self.addAlarmViewModel.setTune(tune)
        }
        navigationController?.pushViewController(alarmVC, animated: true)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.gray.withAlphaComponent(0.3)
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
        cell.textLabel?.text = NSLocalizedString("Label", comment: "")
        cell.accessoryView = cell.chevronView
        cell.detailTextLabel?.text = addAlarmViewModel.label
        return cell
    }
    
    private func createRepeatMenuCell() -> AddEditAlarmMenuCell {
        let cell = AddEditAlarmMenuCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = NSLocalizedString("Repeat", comment: "")
        cell.detailTextLabel?.text = addAlarmViewModel.getRepeatTimeString()
        cell.accessoryView = cell.chevronView
        return cell
    }
    
    private func createSoundMenuCell() -> AddEditAlarmMenuCell {
        let cell = AddEditAlarmMenuCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = NSLocalizedString("Sounds", comment: "")
        cell.detailTextLabel?.text = addAlarmViewModel.tune.name
        cell.accessoryView = cell.chevronView
        return cell
    }
    
    private func createDeleteMenuCell() -> AddEditAlarmMenuCell {
        let cell = AddEditAlarmMenuCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = NSLocalizedString("Delete Alarm", comment: "")
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
}

extension AddEditAlarmVC: UIPickerViewDelegate, UIPickerViewDataSource {
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
        return timePickerView.frame.size.width / 4
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let h = HOURS[timePickerView.selectedRow(inComponent: 0)]
        let m = MINUTES[timePickerView.selectedRow(inComponent: 1)]
        addAlarmViewModel.setPickedTime(h: h, m: m)
    }
}

extension AddEditAlarmVC: AddEditAlarmVMDelegate {
    
    func repeatTimeChanged(text: String) {
        repeatMenuCell.detailTextLabel?.text = text
    }
    
    func tuneChanged(tune: Tune) {
        soundMenuCell.detailTextLabel?.text = tune.name
    }
    
    func alarmLabelChanged(text: String) {
        labelMenuCell.detailTextLabel?.text = text
    }
    
    func pickedTimeChanged(time: TimeStruct) {
        timePickerView.selectRow(time.hours, inComponent: 0, animated: false)
        timePickerView.selectRow(time.minutes, inComponent: 1, animated: false)
    }
}

extension AddEditAlarmVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return addAlarmViewModel.inEditMode ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewMenuItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableViewMenuItems[indexPath.section][indexPath.row].tableViewCell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableViewMenuItems[indexPath.section][indexPath.row].performAction()
    }
}

class TableViewMenuItem {
    
    private(set) var tableViewCell: UITableViewCell
    
    private var itemAction: (() -> Void)? = nil
    
    init(tableViewCell: UITableViewCell, itemAction: (() -> Void)? = nil) {
        self.tableViewCell = tableViewCell
        self.itemAction = itemAction
    }
    
    func setAction(_ action: @escaping () -> Void) {
        itemAction = action
    }
    
    func performAction() {
        itemAction?()
    }
}
