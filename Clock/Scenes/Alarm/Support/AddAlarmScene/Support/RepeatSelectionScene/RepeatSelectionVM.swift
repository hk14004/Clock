//
//  RepeatSelectionVM.swift
//  Clock
//
//  Created by Hardijs on 08/10/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class RepeatSelectionVM {
    
    private(set) var selectedDays: Set<WeekDay> = []
    
    private(set) var allDays: [WeekDay] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    
    private lazy var weekdaySelectionCellVMs = createCellVMs()
    
    private func createCellVMs() -> [WeekDaySelectionCellVM] {
        return allDays.compactMap { WeekDaySelectionCellVM(weekDay: $0, isSelected: selectedDays.contains($0)) }
    }
    
    func getCellViewModel(at: IndexPath) -> WeekDaySelectionCellVM {
        return weekdaySelectionCellVMs[at.row]
    }
    
    func selectDay(at: IndexPath) {
        let vm = getCellViewModel(at: at)
        vm.isSelected = !vm.isSelected
        if vm.isSelected {
            selectedDays.insert(vm.weekDay)
        } else {
            selectedDays.remove(vm.weekDay)
        }
    }
    
    func setSelectedDays(_ selected: Set<WeekDay>) {
        selectedDays.formUnion(selected)
    }
}
