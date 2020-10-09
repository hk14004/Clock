//
//  WorldClockViewController.swift
//  Clock
//
//  Created by Hardijs on 16/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class WorldClockVC: UIViewController {
    
    private let worldClockViewModel: WorldClockVM = WorldClockVM()
    
    private var tableView: UITableView = UITableView()
    
    private let noClockLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Secondary")
        worldClockViewModel.delegate = self
        setupNavigationBar()
        setupTableView()
        setupNoClockLabel()
        if worldClockViewModel.visibleTimeZones.isEmpty {
            prepareVCForEmptyTable()
        } else {
            prepareVCForNotEmptyTable()
        }
    }
    
    private func setupNavigationBar() {
        title = NSLocalizedString("World Clock", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        
        // Navigation items
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = add
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        worldClockViewModel.setEditing(editing)
        tableView.setEditing(editing, animated: true)
    }
    
    @objc func addTapped() {
        let nav = UINavigationController(rootViewController: CitiesPickerVC())
        nav.modalPresentationStyle = .popover
        present(nav, animated: true, completion: nil)
    }
    
    private func setupNoClockLabel() {
        if  worldClockViewModel.visibleTimeZones.count != 0 {
            noClockLabel.isHidden = true
        }
        noClockLabel.text = NSLocalizedString("No World Clocks", comment: "")
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
        navigationItem.leftBarButtonItem = nil
    }
    
    private func prepareVCForNotEmptyTable() {
        showTableView()
        noClockLabel.isHidden = true
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension WorldClockVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WordlClockTableViewCell
        cell.setup(with: worldClockViewModel.timeZoneCellViewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldClockViewModel.visibleTimeZones.count
    }
}

extension WorldClockVC: WorldClockViewModelDelegate {
    func timeZoneListChanged(list: [TimeZone]) {
        if list.isEmpty {
            prepareVCForEmptyTable()
        } else {
            prepareVCForNotEmptyTable()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
    }
}

extension WorldClockVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        worldClockViewModel.changeOrderOfClock(at: sourceIndexPath, to: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
            tableView.beginUpdates()
            self.worldClockViewModel.deleteTimeZone(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            complete(true)
        }
        
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        super.setEditing(false, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        super.setEditing(true, animated: true)
    }
}
