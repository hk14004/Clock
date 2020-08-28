//
//  TuneSelectionViewModel.swift
//  Clock
//
//  Created by Hardijs on 28/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class TuneSelectionViewModel: NSObject {
    
    private(set) var availableTunes: [Tune] = TuneSelectionViewModel.getAvailableTunes()
    
    let defaultTune: Tune = TuneSelectionViewModel.getDefaultTune()
    
    var tuneCellViewModels: [TuneCellViewModel] = []
    
    override init() {
        super.init()
        self.tuneCellViewModels = createTuneCellViewModels()
    }
    
    func getTuneCellViewModel(at: Int) -> TuneCellViewModel {
        return tuneCellViewModels[at]
    }
    
    private func createTuneCellViewModels() -> [TuneCellViewModel] {
        return availableTunes.compactMap {
            return TuneCellViewModel(tune: $0, isDefault: $0.name == defaultTune.name ? true : false)
        }
    }
    
    private static func getAvailableTunes() -> [Tune] {
        // Get all tune urls
        guard let urls: [URL] = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: "Tunes") else {
            return []
        }
        
        // Create tune array
        let tunes: [Tune] = urls.compactMap {
            let split = $0.lastPathComponent.split(separator: ".")
            return Tune(name: "\(split[0])", format: "\(split[1])")
        }
        
        return tunes
    }
    
    private static func getDefaultTune() -> Tune {
        let decoded  = UserDefaults.standard.object(forKey: DEFAULT_TUNE_KEY) as! Data
        let decodedTune = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Tune

        return decodedTune
    }
    
    func selectTune(at: Int) {
        if let currentDefault = tuneCellViewModels.first(where: { $0.isdefault }) {
            currentDefault.isdefault = false
        }
        tuneCellViewModels[at].isdefault = true
    }
    
    func save() {
        if let currentDefaultViewModel = tuneCellViewModels.first(where: { $0.isdefault }) {
            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: currentDefaultViewModel.tune, requiringSecureCoding: false)

            UserDefaults.standard.set(encodedData, forKey: DEFAULT_TUNE_KEY)
        }
    }
}
