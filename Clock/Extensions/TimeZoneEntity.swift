//
//  TimeZoneEntity.swift
//  Clock
//
//  Created by Hardijs on 09/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

extension TimeZoneEntity {
    func createTimeZoneObject() -> TimeZone? {
        guard let id = identifier else { return nil }
        return TimeZone(identifier: id)
    }
}
