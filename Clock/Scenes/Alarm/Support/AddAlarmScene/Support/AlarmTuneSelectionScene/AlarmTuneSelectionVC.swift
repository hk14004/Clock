//
//  AlarmTuneSelectionVC.swift
//  Clock
//
//  Created by Hardijs on 02/10/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AlarmTuneSelectionVC: TuneSelectionBaseVC {
    
    private var alarmTuneSelectionVM = AlarmTuneSelectionVM()
    
    var onTuneSelected: ((Tune)->Void)?
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Sound"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alarmTuneSelectionVM.selectTune(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmTuneSelectionVM.availableTunes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: TuneSelectionCell.identifier) as! TuneSelectionCell
        cell.setup(viewModel: alarmTuneSelectionVM.getTuneCellViewModel(at: indexPath.row))
        return cell
    }
    
    func selectTune(_ tune: Tune) {
        alarmTuneSelectionVM.selectTune(tune)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        onTuneSelected?(alarmTuneSelectionVM.getSelectedTune())
    }
    @objc override func cancelTapped() {
        print("Cancel")
        dissappear()
    }
    
    @objc override func setTapped() {
        print("Set")
        dissappear()
    }
    
    override func dissappear() {
        navigationController?.popViewController(animated: true)
    }
}
