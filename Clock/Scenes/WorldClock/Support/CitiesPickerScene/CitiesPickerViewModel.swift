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
    
    private(set) var visibleTimeZones: [[TimeZone]] = [[]] {
        didSet {
            delegate?.timezoneListChanged(timezones: visibleTimeZones)
        }
    }
    
    private var allTimezones: [TimeZone] = []
    
    private(set) var sectionsData = SectionsData<TimeZone>(titles: [], data: [])
            
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
        let sorted = allTimezones.sorted { $0.cityName < $1.cityName }
        visibleTimeZones = groupInSections(data: sorted)
        sectionsData.titles = visibleTimeZones.compactMap { $0.first?.cityName.first }.compactMap { String($0) }
        sectionsData.data = visibleTimeZones
        latestItemOrder = getLatestIndex()
    }
    
    private(set) var isSearching: Bool = false
    
    private func groupInSections(data: [TimeZone]) -> [[TimeZone]] {
        return data.reduce([[TimeZone]]()) {
            guard var last = $0.last else { return [[$1]] }
            var collection = $0
            if last.first!.cityName.first == $1.cityName.first {
                last += [$1]
                collection[collection.count - 1] = last
            } else {
                collection += [[$1]]
            }
            return collection
        }
    }
    
    func filter(query: String) {
        isSearching = !query.isEmpty

        // Make sure user typed something
        guard !query.isEmpty else {
            visibleTimeZones = sectionsData.data
            return
        }

        // Filter timezones and set results
        var filtered: [[TimeZone]] = [[]]
        /// Search results dont require multiple sections
        filtered[0] = allTimezones.filter { $0.identifier.lowercased().contains(query.lowercased())}
        
        visibleTimeZones = filtered
    }
    
    func addTimezone(indexPath: IndexPath) {
        timeZoneEntityDAO.addTimezone { (created) in
            created.identifier = visibleTimeZones[indexPath.section][indexPath.row].identifier
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
    func timezoneListChanged(timezones: [[TimeZone]])
}


struct SectionsData<T> {
    var titles: [String]
    var data : [[T]]

    
    subscript(sectionIndex: Int) -> [T] {
        return data[sectionIndex]
    }
    
    subscript(sectionIndex: Int, rowIndex: Int) -> T {
        return data[sectionIndex][rowIndex]
    }
}
