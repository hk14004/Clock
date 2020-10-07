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
    
    var tuneCellViewModels: [TuneCellViewModel] = []
    
     init() {
        tuneCellViewModels = createTuneCellViewModels()
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
    
    func selectTune(_ tune: Tune) {
        tuneCellViewModels.forEach { $0.isdefault = false }
        tuneCellViewModels.first(where: { $0.tune.name == tune.name })?.isdefault = true
    }
    
    func getSelectedTune() -> Tune {
        return tuneCellViewModels.first { $0.isdefault }!.tune
    }
}
