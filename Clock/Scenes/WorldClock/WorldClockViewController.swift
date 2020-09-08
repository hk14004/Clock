//
//  WorldClockViewController.swift
//  Clock
//
//  Created by Hardijs on 16/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class WorldClockViewController: UIViewController {
        
    private let worldClockViewModel: WorldClockViewModel = WorldClockViewModel()
    
    private var tableView: UITableView = UITableView()
    
    private let noClockLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Secondary")
        worldClockViewModel.delegate = self
        setupNavigationBar()
        setupTableView()
        setupNoClockLabel()
    }
    
    private func setupNavigationBar() {
        title = "World Clock"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        
        // Navigation items
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        //let edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(addTapped))

        navigationItem.rightBarButtonItem = add
        //navigationItem.leftBarButtonItem = edit
    }
    
    @objc func addTapped() {
        let nav = UINavigationController(rootViewController: CitiesPickerViewController())
        nav.modalPresentationStyle = .popover
        present(nav, animated: true, completion: nil)
    }
    
    private func setupNoClockLabel() {
        if  worldClockViewModel.visibleTimeZones.count != 0 {
            noClockLabel.isHidden = true
        }
        noClockLabel.text = "No World Clocks"
        noClockLabel.textColor = .gray
        noClockLabel.font = noClockLabel.font.withSize(30)
        
        view.addSubview(noClockLabel)
        noClockLabel.translatesAutoresizingMaskIntoConstraints = false
        noClockLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noClockLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupTableView() {
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.register(WordlClockTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.delegate = self

        if  worldClockViewModel.visibleTimeZones.count == 0 {
            hideTableView()
        }
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func hideTableView() {
        tableView.isOpaque = true
        tableView.alpha = 0.1
    }
    
    private func showTableView() {
        tableView.isOpaque = false
        tableView.alpha = 1
    }
    
    private func prepareVCForEmptyTable() {
        hideTableView()
        noClockLabel.isHidden = false
    }
    
    private func prepareVCForNotEmptyTable() {
        showTableView()
        noClockLabel.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension WorldClockViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WordlClockTableViewCell
        cell.setup(with: worldClockViewModel.visibleTimeZones[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldClockViewModel.visibleTimeZones.count
    }
}

extension WorldClockViewController: WorldClockViewModelDelegate {
    func timeZoneListChanged(list: [TimeZone]) {
        if list.isEmpty {
            prepareVCForEmptyTable()
        } else {
            prepareVCForNotEmptyTable()
        }
        tableView.reloadData()
    }
}

extension WorldClockViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
