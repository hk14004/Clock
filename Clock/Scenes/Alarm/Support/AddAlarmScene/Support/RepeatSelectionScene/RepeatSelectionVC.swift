//
//  RepeatSelectionVC.swift
//  Clock
//
//  Created by Hardijs on 08/10/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class RepeatSelectionVC: SelectionBaseVC {
    
    private var repeatSelectionVM = RepeatSelectionVM()
    
    var onSelectionCompleted: ((Set<WeekDay>) -> Void)?
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Repeat"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionCell.identifier) as! SelectionCell
        let vm = repeatSelectionVM.getCellViewModel(at: indexPath)
        vm.delegate = cell
        cell.setup(itemName: vm.itemName, isSelected: vm.isSelected)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repeatSelectionVM.allDays.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repeatSelectionVM.selectDay(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setPreselectedDays(preSelected: Set<WeekDay>) {
        repeatSelectionVM.setSelectedDays(preSelected)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        onSelectionCompleted?(repeatSelectionVM.selectedDays)
    }
}
