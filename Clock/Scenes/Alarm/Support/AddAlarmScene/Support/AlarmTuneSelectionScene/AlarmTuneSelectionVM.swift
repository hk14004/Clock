//
//  AlarmTuneSelectionVM.swift
//  Clock
//
//  Created by Hardijs on 07/10/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import Foundation

class AlarmTuneSelectionVM {
    
    private(set) var availableTunes: [Tune] = AlarmTunes.shared
        .getAvailableTunes()
    
    let defaultTune: Tune = AlarmTunes.shared.getDefaultTune()
    
    var tuneCellViewModels: [TuneCellVM] = []
    
     init() {
        tuneCellViewModels = createTuneCellViewModels()
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
    
    func selectTune(_ tune: Tune) {
        tuneCellViewModels.forEach { $0.isSelected = false }
        tuneCellViewModels.first(where: { $0.tune.name == tune.name })?.isSelected = true
    }
    
    func getSelectedTune() -> Tune {
        return tuneCellViewModels.first { $0.isSelected }!.tune
    }
}
