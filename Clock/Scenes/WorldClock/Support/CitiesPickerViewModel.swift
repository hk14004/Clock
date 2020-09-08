//
//  CitiesPickerViewModel.swift
//  Clock
//
//  Created by Hardijs on 07/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class CitiesPickerViewModel {
    
    weak var delegate: CitiesPickerViewModelDelegate?
    
    private(set) var visibleTimeZones: [TimeZone] {
        didSet {
            delegate?.timezoneListChanged(timezones: visibleTimeZones)
        }
    }
    
    private var allTimezones: [TimeZone]
        
    required init() {
        allTimezones = TimeZone.knownTimeZoneIdentifiers.compactMap { TimeZone(identifier: $0) }
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
}

protocol CitiesPickerViewModelDelegate: class {
    func timezoneListChanged(timezones: [TimeZone])
}
