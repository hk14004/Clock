//
//  AlarmTuneSelectionVC.swift
//  Clock
//
//  Created by Hardijs on 02/10/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AlarmTuneSelectionVC: SelectionBaseVC {
    
    private var alarmTuneSelectionVM = AlarmTuneSelectionVM()
    
    var onTuneSelected: ((Tune)->Void)?
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = NSLocalizedString("Sound", comment: "")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alarmTuneSelectionVM.selectTune(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmTuneSelectionVM.availableTunes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: SelectionCell.identifier) as! SelectionCell
        let viewModel = alarmTuneSelectionVM.getTuneCellViewModel(at: indexPath.row)
        viewModel.delegate = cell
        cell.setup(itemName: viewModel.tune.name, isSelected: viewModel.isSelected)
        return cell
    }
    
    func selectTune(_ tune: Tune) {
        alarmTuneSelectionVM.selectTune(tune)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        onTuneSelected?(alarmTuneSelectionVM.getSelectedTune())
    }
    
    override func dissappear() {
        navigationController?.popViewController(animated: true)
    }
}
