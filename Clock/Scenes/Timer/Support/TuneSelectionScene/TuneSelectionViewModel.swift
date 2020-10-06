//
//  TuneSelectionViewModel.swift
//  Clock
//
//  Created by Hardijs on 28/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class TuneSelectionViewModel: NSObject {
    
    private(set) var availableTunes: [Tune] = AlarmTunes.shared
        .getAvailableTunes()
    
    let defaultTune: Tune = AlarmTunes.shared.getDefaultTune()
    
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
