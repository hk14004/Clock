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
    
    private(set) var visibleTimeZones: [TimeZone] = [] {
        didSet {
            delegate?.timezoneListChanged(timezones: visibleTimeZones)
        }
    }
    
    private var allTimezones: [TimeZone] = []
        
    private lazy var persistentContainer: NSPersistentContainer = {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<TimeZoneEntity> = {
        let request = NSFetchRequest<TimeZoneEntity>(entityName: "TimeZoneEntity")
        let sort = NSSortDescriptor(key: "identifier", ascending: false)
        request.sortDescriptors = [sort]
        let controller = NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: persistentContainer.viewContext,
                                          sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }()
    
    required override init() {
        super.init()
        try! fetchedResultsController.performFetch()
        let savedTimeZonesIds: [String] = fetchedResultsController.fetchedObjects?.compactMap { $0.identifier } ?? []
        allTimezones = TimeZone.knownTimeZoneIdentifiers.compactMap {
            if !savedTimeZonesIds.contains($0) {
                return TimeZone(identifier: $0)
            }
            return nil
        }
        visibleTimeZones = allTimezones
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
        let new = TimeZoneEntity(context: persistentContainer.viewContext)
        new.identifier = visibleTimeZones[indexPath.row].identifier
        save()
    }
    
    private func save() {
        try! persistentContainer.viewContext.save()
    }
}

protocol CitiesPickerViewModelDelegate: class {
    func timezoneListChanged(timezones: [TimeZone])
}
