//
//  Constants.swift
//  Clock
//
//  Created by Hardijs on 18/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

let SECONDS: [Int] = makeIntArray(from: 0, to: 59)

let MINUTES: [Int] = makeIntArray(from: 0, to: 59)

let HOURS: [Int] = makeIntArray(from: 0, to: 23)

let DEFAULT_TUNE_KEY = "DEFAULT_TUNE"

let FALLBACK_DEFAULT_TUNE = Tune(name: "Radar", format: "mp3")
