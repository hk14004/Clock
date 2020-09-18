//
//  AlarmViewModel.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation
import CoreData

class AlarmViewModel: NSObject {
    
    weak var delegate: AlarmViewModelDelegate?
    
    private(set) var sectionsData: SectionsData<AlarmEntity>! {
        didSet {
            delegate?.alarmListChanged()
        }
    }

    private let alarmDAO = EntityDAO<AlarmEntity>()
    
    private(set) var alarmViewmodels: [IndexPath: AlarmTableViewCellViewModel] = [:]
    
    override init() {
        super.init()
        alarmDAO.delegate = self
        loadAlarmSections()
    }
    
    private func loadAlarmSections() {
        let alarms = alarmDAO.loadData()
        sectionsData = SectionsData(titles: ["Bedtime".uppercased(), "Other Alarms".uppercased()], data: createSections(from: alarms))
    }
    
    private func createSections(from alarms: [AlarmEntity]) -> [[AlarmEntity]] {
        // Bedtime alarms
        let bedtimeAlarms: [AlarmEntity] = alarms.filter { $0.bedtime == true }
        
        // Other alarms
        let otherAlarms: [AlarmEntity] = alarms.filter { $0.bedtime == false }
        
        return [bedtimeAlarms, otherAlarms]
    }
    
    func getAlarmCellViewModel(at indexPath: IndexPath) -> AlarmTableViewCellViewModel {
        let entity = sectionsData[indexPath.section][indexPath.row]
        let viewModel = AlarmTableViewCellViewModel(alarm: entity)
        alarmViewmodels[indexPath] = viewModel
        return viewModel
    }
}

extension AlarmViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        sectionsData.data = createSections(from: controller.fetchedObjects as! [AlarmEntity])
    }
}

protocol AlarmViewModelDelegate: class {
    func alarmListChanged()
}
