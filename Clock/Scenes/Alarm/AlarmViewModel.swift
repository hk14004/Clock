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
    
    private(set) var sectionData: SectionsData = SectionsData(titles: [], data: [[]])
    
    private let alarmDAO = EntityDAO<AlarmEntity>()
    
    init() {
        let loaded = alarmDAO.loadData()
        print("Stored alarms: ", loaded)
    }
}
