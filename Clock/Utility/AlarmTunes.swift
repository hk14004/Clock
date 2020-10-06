//
//  AlarmTunes.swift
//  Clock
//
//  Created by Hardijs on 06/10/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class AlarmTunes {
    
    static let shared: AlarmTunes = AlarmTunes()
    
    func getAvailableTunes() -> [Tune] {
        // Get all tune urls
        guard
            let urls: [URL] = Bundle.main.urls(forResourcesWithExtension: "caf", subdirectory: nil),
            !urls.isEmpty
        else {
            return []
        }
        
        // Create tune array
        let tunes: [Tune] = urls.compactMap {
            let split = $0.lastPathComponent.split(separator: ".")
            return Tune(name: "\(split[0])", format: "\(split[1])")
        }
        
        return tunes
    }
    
    func getDefaultTune() -> Tune {
        let decoded  = UserDefaults.standard.object(forKey: DEFAULT_TUNE_KEY) as! Data
        let decodedTune = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Tune

        return decodedTune
    }
}
