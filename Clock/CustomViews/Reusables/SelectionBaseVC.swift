//
//  TuneSelectionBaseVC.swift
//  Clock
//
//  Created by Hardijs on 06/10/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class SelectionBaseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "Primary")
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func dissappear() {}
    
    func setupTableView() {
        tableView.register(SelectionCell.self, forCellReuseIdentifier: SelectionCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "Primary")
        tableView.separatorInset = .init(top: 0, left: 55, bottom: 0, right: 0)
        view.addSubview(tableView)
        tableView.separatorColor = UIColor.gray.withAlphaComponent(0.3)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.rowHeight = 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Ovveride this method")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Ovveride this method")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fatalError("Ovveride this method")
    }
}
