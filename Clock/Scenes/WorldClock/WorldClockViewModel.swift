//
//  WorldClockViewModel.swift
//  Clock
//
//  Created by Hardijs on 07/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit
import CoreData

class WorldClockViewModel: NSObject {
    
    weak var delegate: WorldClockViewModelDelegate?
    
    private(set) var visibleTimeZones: [TimeZone] = [] {
        didSet {
            timeZoneCellViewModels = visibleTimeZones.compactMap { WordlClockTableViewCellModel(timeZoneId: $0.identifier) }
            delegate?.timeZoneListChanged(list: visibleTimeZones)
        }
    }
    
    private(set) var timeZoneCellViewModels: [WordlClockTableViewCellModel] = []
    
    private var timeZoneDAO = TimeZoneEntityDAO()
    
    private var timer: Timer!

    required override init() {
        super.init()
        visibleTimeZones = timeZoneDAO.loadData().compactMap {
            guard let fetchedID = $0.identifier else { return nil }
            return TimeZone(identifier: fetchedID)
        }
        timeZoneCellViewModels = visibleTimeZones.compactMap { WordlClockTableViewCellModel(timeZoneId: $0.identifier) }

        timeZoneDAO.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateClockTimes), userInfo: nil, repeats: true)
    }
    
    deinit {
        timer.invalidate()
    }
    
    @objc func updateClockTimes(timer: Timer) {
        timeZoneCellViewModels.forEach { $0.currentTime = Date() }
    }
    
    func deleteTimeZone(at: IndexPath) {
        timeZoneDAO.delete(at: at)
    }
    
    func setEditing(_ editing: Bool) {
        timeZoneCellViewModels.forEach { $0.hideTime = editing }
    }
}

extension WorldClockViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard controller === timeZoneDAO.fetchedController else { return }
        visibleTimeZones = timeZoneDAO.fetchedController?.fetchedObjects?.compactMap { $0.createTimeZoneObject() }  ?? []
    }
}

protocol WorldClockViewModelDelegate: class {
    func timeZoneListChanged(list: [TimeZone])
}
