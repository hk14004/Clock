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
            timeZoneCellViewModels = visibleTimeZones.compactMap { WordlClockTableViewCellModel(timeZoneId: $0.identifier, isEditing: isEditing) }
            delegate?.timeZoneListChanged(list: visibleTimeZones)
        }
    }
    
    private(set) var timeZoneCellViewModels: [WordlClockTableViewCellModel] = []
    
    private var timeZoneDAO = TimeZoneEntityDAO()
    
    private var timer: Timer!
    
    private var isEditing: Bool = false {
        didSet {
            timeZoneCellViewModels.forEach { $0.isEditing = isEditing }
        }
    }

    required override init() {
        super.init()
        visibleTimeZones = timeZoneDAO.loadData(requestModifier: { (request) in
            request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        }).compactMap {
            guard let fetchedID = $0.identifier else { return nil }
            return TimeZone(identifier: fetchedID)
        }
        timeZoneCellViewModels = visibleTimeZones.compactMap { WordlClockTableViewCellModel(timeZoneId: $0.identifier, isEditing: isEditing) }

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
        isEditing = editing
    }
    
    func changeOrderOfClock(at: IndexPath, to: IndexPath) {
        // Make sure move is worth processing
        guard at.row != to.row else { return }
        
        // Process related order changes for other objects
        if at.row < to.row {
            for n in at.row...to.row {
                timeZoneDAO.fetchedController?.fetchedObjects?[n].order -= 1
            }
        } else {
            for n in to.row...at.row {
                timeZoneDAO.fetchedController?.fetchedObjects?[n].order += 1
            }
        }
        
        // Set moved item order
        timeZoneDAO.fetchedController?.fetchedObjects?[at.row].order = Int64(to.row)

        timeZoneDAO.save()
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
