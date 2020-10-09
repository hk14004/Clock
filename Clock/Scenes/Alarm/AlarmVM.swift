//
//  AlarmViewModel.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation
import CoreData

class AlarmVM: NSObject {
    
    weak var delegate: AlarmViewModelDelegate?
    
    private(set) var sectionsData: SectionsData<AlarmEntity>! {
        didSet {
            delegate?.alarmListChanged()
        }
    }

    private let alarmDAO = EntityDAO<AlarmEntity>()
    
    private(set) var alarmViewmodels: [IndexPath: AlarmTableViewCellVM] = [:]
    
    override init() {
        super.init()
        alarmDAO.delegate = self
        loadAlarmSections()
    }
    
    private func loadAlarmSections() {
        let alarms = alarmDAO.loadData()
        let sleepText = NSLocalizedString("Sleep", comment: "")
        let wakeUpText = NSLocalizedString("Wake Up", comment: "")
        let otherText = NSLocalizedString("Other", comment: "")
        sectionsData = SectionsData(titles: ["\(sleepText) | \(wakeUpText)","\(otherText)"],
                                    data: createSections(from: alarms))
    }
    
    private func createSections(from alarms: [AlarmEntity]) -> [[AlarmEntity]] {
        // Bedtime alarms
        let bedtimeAlarms: [AlarmEntity] = alarms.filter { $0.bedtime == true }
        
        // Other alarms
        let otherAlarms: [AlarmEntity] = alarms.filter { $0.bedtime == false }
        
        return [bedtimeAlarms, otherAlarms]
    }
    
    func getAlarmCellViewModel(at indexPath: IndexPath) -> AlarmTableViewCellVM {
        let entity = sectionsData[indexPath.section][indexPath.row]
        let viewModel = AlarmTableViewCellVM(alarm: entity)
        alarmViewmodels[indexPath] = viewModel
        return viewModel
    }
    
    func deleteAlarm(at: IndexPath) {
        let toBeDeleted = sectionsData[at.section][at.row]
        alarmDAO.delete([toBeDeleted])
    }
}

extension AlarmVM: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        sectionsData.data = createSections(from: controller.fetchedObjects as! [AlarmEntity])
    }
}

protocol AlarmViewModelDelegate: class {
    func alarmListChanged()
}
