//
//  AlarmTuneSelectionVC.swift
//  Clock
//
//  Created by Hardijs on 02/10/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AlarmTuneSelectionVC: TuneSelectionBaseVC {
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Sound"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return UITableViewCell()
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
