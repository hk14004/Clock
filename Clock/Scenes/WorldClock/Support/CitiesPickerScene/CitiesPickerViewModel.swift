//
//  CitiesPickerViewModel.swift
//  Clock
//
//  Created by Hardijs on 07/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit
import CoreData

class CitiesPickerViewModel: NSObject {
    
    weak var delegate: CitiesPickerViewModelDelegate?
    
    private var timeZoneEntityDAO = TimeZoneEntityDAO()
    
    private(set) var visibleTimeZones: [TimeZone] = [] {
        didSet {
            delegate?.timezoneListChanged(timezones: visibleTimeZones)
        }
    }
    
    private var allTimezones: [TimeZone] = []
            
    private var latestItemOrder: Int64?
    
    required override init() {
        super.init()
        let savedTimeZonesIds: [String] = timeZoneEntityDAO.loadData().compactMap { $0.identifier }
        allTimezones = TimeZone.knownTimeZoneIdentifiers.compactMap {
            if !savedTimeZonesIds.contains($0) {
                return TimeZone(identifier: $0)
            }
            return nil
        }
        visibleTimeZones = allTimezones
        latestItemOrder = getLatestIndex()
    }
    
    private var isSearching: Bool = false
    
    func filter(query: String) {
        isSearching = !query.isEmpty
        
        guard !query.isEmpty else {
            visibleTimeZones = allTimezones
            return
        }
        
        visibleTimeZones = allTimezones.filter { $0.identifier.lowercased().contains(query.lowercased())}
    }
    
    func addTimezone(indexPath: IndexPath) {
        timeZoneEntityDAO.addTimezone { (created) in
            created.identifier = visibleTimeZones[indexPath.row].identifier
            if let latestOrder = latestItemOrder {
                created.order = latestOrder + 1
            } else {
                created.order = 0
            }
        }
    }
    
    func getLatestIndex() -> Int64? {
        let request: NSFetchRequest<TimeZoneEntity> = TimeZoneEntity.fetchRequest()
        request.fetchLimit = 1
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: false)]
        let result = try! timeZoneEntityDAO.persistentConatiner.viewContext.fetch(request)
        guard let lastItem = result.first else { return nil }
        return lastItem.order
    }
}

protocol CitiesPickerViewModelDelegate: class {
    func timezoneListChanged(timezones: [TimeZone])
}
