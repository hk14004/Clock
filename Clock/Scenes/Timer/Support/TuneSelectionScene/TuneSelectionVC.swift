//
//  TuneSelectionViewController.swift
//  Clock
//
//  Created by Hardijs on 24/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class TuneSelectionVC: SelectionBaseVC {
    
    private let tuneSelectionViewModel: TuneSelectionVM = TuneSelectionVM()
    
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
        title = NSLocalizedString("When Timer Ends", comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Set", comment: ""),
                                                                 style: .done, target: self, action: #selector(setTapped))
    }
        
    @objc func setTapped() {
        dissappear()
    }
    
    override func dissappear() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tuneSelectionViewModel.save()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tuneSelectionViewModel.selectTune(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tuneSelectionViewModel.availableTunes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionCell.identifier, for: indexPath) as! SelectionCell
        let viewModel = tuneSelectionViewModel.getTuneCellViewModel(at: indexPath.row)
        viewModel.delegate = cell
        cell.setup(itemName: viewModel.tune.name, isSelected: viewModel.isSelected)
        return cell
    }
}
