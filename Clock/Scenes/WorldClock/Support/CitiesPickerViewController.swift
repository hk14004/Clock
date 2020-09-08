//
//  CitiesPickerViewController.swift
//  Clock
//
//  Created by Hardijs on 07/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class CitiesPickerViewController: UIViewController {
    
    private let citiesPickerViewModel: CitiesPickerViewModel = CitiesPickerViewModel()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = UITableView()
    
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Primary")
        citiesPickerViewModel.delegate = self
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupNavigationBar() {
        title = "Choose a City"
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension CitiesPickerViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        citiesPickerViewModel.filter(query: searchController.searchBar.text!)
    }
}

extension CitiesPickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesPickerViewModel.visibleTimeZones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let empty = tableView.dequeueReusableCell(withIdentifier: "cell")!
        empty.textLabel?.text = citiesPickerViewModel.visibleTimeZones[indexPath.row].identifier
        empty.backgroundColor = .clear
        empty.textLabel?.textColor = .white
        return empty
    }
}

extension CitiesPickerViewController: CitiesPickerViewModelDelegate {
    func timezoneListChanged(timezones: [TimeZone]) {
        tableView.reloadData()
    }
}
