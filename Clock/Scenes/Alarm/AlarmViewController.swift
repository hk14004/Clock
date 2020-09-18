//
//  AlarmViewController.swift
//  Clock
//
//  Created by Hardijs on 16/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    
    private let alarmViewmodel = AlarmViewModel()
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Secondary")
        alarmViewmodel.delegate = self
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        title =  "Alarm"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        // Navigation items
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = add
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @objc func addTapped() {
        let nav = UINavigationController(rootViewController: AddAlarmViewController())
        nav.modalPresentationStyle = .popover
        present(nav, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        tableView.rowHeight = 88
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func createBedtimeSectionTitleView() -> UIView {
        let returnedView = UIView()
        returnedView.backgroundColor = UIColor(named: "Secondary")
        
        let imageView = UIImageView(image: UIImage(systemName: "bed.double.fill"))
        returnedView.addSubview(imageView)
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: returnedView.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: returnedView.leadingAnchor, constant: 15).isActive = true
        
        let label = UILabel()
        label.text = alarmViewmodel.sectionsData.titles[0]
        returnedView.addSubview(label)
        label.textColor = .gray
        label.font = label.font.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: returnedView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
        
        return returnedView
    }
    
    private func createOtherSectionTitleView() -> UIView {
        let returnedView = UIView()
        returnedView.backgroundColor = UIColor(named: "Secondary")
        
        let label = UILabel()
        label.text = alarmViewmodel.sectionsData.titles[1]
        returnedView.addSubview(label)
        label.textColor = .gray
        label.font = label.font.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: returnedView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: returnedView.leadingAnchor, constant: 15).isActive = true
        
        return returnedView
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
}

extension AlarmViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return alarmViewmodel.sectionsData.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmViewmodel.sectionsData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AlarmTableViewCell
        
        cell.setup(with: alarmViewmodel.getAlarmCellViewModel(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return indexPath.section == 0 ? .none : .delete
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return createBedtimeSectionTitleView()
        } else {
            return createOtherSectionTitleView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? false : true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard  indexPath.section != 0 else {
            return nil
        }

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
            //            tableView.beginUpdates()
            //             TODO: Delete alarm from DB
            //            tableView.deleteRows(at: [indexPath], with: .automatic)
            //            tableView.endUpdates()
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

extension AlarmViewController: AlarmViewModelDelegate {
    func alarmListChanged() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.tableView.reloadData()
        }
    }
}
