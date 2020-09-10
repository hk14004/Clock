//
//  TimeZone.swift
//  Clock
//
//  Created by Hardijs on 10/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

extension TimeZone {
    var cityName: String {
        get {
            identifier.split(separator: "/").last?.replacingOccurrences(of: "_", with: " ") ?? "Unknown"
        }
    }
}
