//
//  AlarmViewModel.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation
import CoreData

class AlarmViewModel {
    
    private(set) var sectionsData: SectionsData<AlarmEntity>!

    private let alarmDAO = EntityDAO<AlarmEntity>()
    
    private(set) var alarmViewmodels: [IndexPath: AlarmTableViewCellViewModel] = [:]
    
    init() {
        loadAlarmSections()
    }
    
    private func loadAlarmSections() {
        // Bedtime alarms
        let bedtimeAlarms = alarmDAO.loadData { (request) in
            request.predicate = NSPredicate(format: "bedtime == %@", NSNumber(true))
        }
        
        // Other alarms
        let otherAlarms = alarmDAO.loadData { (request) in
            request.predicate = NSPredicate(format: "bedtime == %@", NSNumber(false))
        }

        sectionsData = SectionsData(titles: ["Bedtime".uppercased(), "Other Alarms".uppercased()], data: [bedtimeAlarms, otherAlarms])
    }
    
    func getAlarmCellViewModel(at indexPath: IndexPath) -> AlarmTableViewCellViewModel {
        let entity = sectionsData[indexPath.section][indexPath.row]
        let viewModel = AlarmTableViewCellViewModel(alarm: entity)
        alarmViewmodels[indexPath] = viewModel
        return viewModel
    }
}
