//
//  TuneSelectionViewController.swift
//  Clock
//
//  Created by Hardijs on 24/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class TuneSelectionViewController: UIViewController {
    
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
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "Primary")
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "When Timer Ends"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Set", style: .done, target: self, action: #selector(setTapped))
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func setTapped() {
        tuneSelectionViewModel.save()
        dismissSelf()
    }
    
    private func setupTableView() {
        tableView.register(TuneSelectionCell.self, forCellReuseIdentifier: "TuneSelectCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "Primary")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.rowHeight = 44
    }
}

extension TuneSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tuneSelectionViewModel.selectTune(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TuneSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tuneSelectionViewModel.availableTunes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TuneSelectCell", for: indexPath)
        let g = cell as! TuneSelectionCell
        g.setup(viewModel: tuneSelectionViewModel.getTuneCellViewModel(at: indexPath.row))
        return g
    }
}
