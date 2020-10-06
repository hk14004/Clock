//
//  TuneSelectionViewController.swift
//  Clock
//
//  Created by Hardijs on 24/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class TuneSelectionViewController: TuneSelectionBaseVC {
    
    private let tuneSelectionViewModel: TuneSelectionViewModel = TuneSelectionViewModel()
    
    private var cancelButton: UIButton = UIButton()
    
    private var titleLabel: UILabel = UILabel()
    
    private var setButton: UIButton = UIButton()
    
    private let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Primary")
        setupNavigationBar()
        setupTableView()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "When Timer Ends"
    }
        
    @objc override func setTapped() {
        tuneSelectionViewModel.save()
        dissappear()
    }
    
    @objc override func cancelTapped() {
        dissappear()
    }

    override func dissappear() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tuneSelectionViewModel.selectTune(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tuneSelectionViewModel.availableTunes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TuneSelectCell", for: indexPath) as! TuneSelectionCell
        cell.setup(viewModel: tuneSelectionViewModel.getTuneCellViewModel(at: indexPath.row))
        return cell
    }
}
