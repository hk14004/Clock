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
            delegate?.timeZoneListChanged(list: visibleTimeZones)
        }
    }
    
    private var timeZoneDAO = TimeZoneEntityDAO()

    required override init() {
        super.init()
        visibleTimeZones = timeZoneDAO.loadData().compactMap {
            guard let fetchedID = $0.identifier else { return nil }
            return TimeZone(identifier: fetchedID)
        }
        timeZoneDAO.delegate = self
    }
    
    func deleteTimeZone(at: IndexPath) {
        timeZoneDAO.delete(at: at)
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
