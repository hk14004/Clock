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
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
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
}

extension AlarmViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return alarmViewmodel.sectionsData.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmViewmodel.sectionsData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.backgroundColor = .clear
        cell.textLabel?.text = "fff"
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return createBedtimeSectionTitleView()
        } else {
            return createOtherSectionTitleView()
        }
    }
}
