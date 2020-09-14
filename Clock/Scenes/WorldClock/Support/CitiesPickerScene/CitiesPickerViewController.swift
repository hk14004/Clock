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
        
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Primary")
        citiesPickerViewModel.delegate = self
        searchController.searchBar.delegate = self
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
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
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.setShowsCancelButton(true, animated: true)
        searchController.hidesNavigationBarDuringPresentation = false
    }
}

extension CitiesPickerViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        citiesPickerViewModel.filter(query: searchController.searchBar.text!)
    }
}

extension CitiesPickerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return citiesPickerViewModel.visibleTimeZones.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesPickerViewModel.visibleTimeZones[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let empty = tableView.dequeueReusableCell(withIdentifier: "cell")!
        empty.textLabel?.text = citiesPickerViewModel.visibleTimeZones[indexPath.section][indexPath.row].cityName
        empty.backgroundColor = .clear
        empty.textLabel?.textColor = .white
        return empty
    }
}

extension CitiesPickerViewController: CitiesPickerViewModelDelegate {
    func timezoneListChanged(timezones: [[TimeZone]]) {
        tableView.reloadData()
    }
}

extension CitiesPickerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return citiesPickerViewModel.isSearching ? 0 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        citiesPickerViewModel.addTimezone(indexPath: indexPath)
        searchController.dismiss(animated: false, completion: nil)
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !citiesPickerViewModel.isSearching else { return nil }
        let returnedView = UIView()
        returnedView.backgroundColor = UIColor.systemGray
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        returnedView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: returnedView.leadingAnchor, constant: 15).isActive = true
        label.centerYAnchor.constraint(equalTo: returnedView.centerYAnchor, constant: 0).isActive = true
        label.textColor = .white
        label.text = citiesPickerViewModel.sectionsData.titles[section]

        return returnedView
    }
}

extension CitiesPickerViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}
