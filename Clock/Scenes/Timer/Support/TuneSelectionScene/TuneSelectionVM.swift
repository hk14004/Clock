//
//  TuneSelectionViewModel.swift
//  Clock
//
//  Created by Hardijs on 28/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class TuneSelectionVM: NSObject {
    
    private(set) var availableTunes: [Tune] = AlarmTunes.shared
        .getAvailableTunes()
    
    let defaultTune: Tune = AlarmTunes.shared.getDefaultTune()
    
    var tuneCellViewModels: [TuneCellVM] = []
    
    override init() {
        super.init()
        self.tuneCellViewModels = createTuneCellViewModels()
    }
    
    func getTuneCellViewModel(at: Int) -> TuneCellVM {
        return tuneCellViewModels[at]
    }
    
    private func createTuneCellViewModels() -> [TuneCellVM] {
        return availableTunes.compactMap {
            return TuneCellVM(tune: $0, isDefault: $0.name == defaultTune.name ? true : false)
        }
    }
        
    func selectTune(at: Int) {
        if let currentDefault = tuneCellViewModels.first(where: { $0.isSelected }) {
            currentDefault.isSelected = false
        }
        tuneCellViewModels[at].isSelected = true
    }
    
    func save() {
        if let currentDefaultViewModel = tuneCellViewModels.first(where: { $0.isSelected }) {
            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: currentDefaultViewModel.tune, requiringSecureCoding: false)

            UserDefaults.standard.set(encodedData, forKey: DEFAULT_TUNE_KEY)
        }
    }
}
