//
//  CitiesPickerViewController.swift
//  Clock
//
//  Created by Hardijs on 07/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class CitiesPickerVC: UIViewController {
    
    private let citiesPickerViewModel = CitiesPickerVM()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = UITableView()
        
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Primary")
        citiesPickerViewModel.delegate = self
        searchController.searchBar.delegate = self
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionIndexColor = .orange
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupNavigationBar() {
        title = NSLocalizedString("Choose a City", comment: "")
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search", comment: "")
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.setShowsCancelButton(true, animated: true)
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    @objc func keyboardWillShow(notif: NSNotification){
        if let newFrame = (notif.userInfo?[ UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue)?.cgRectValue {
            let insets = UIEdgeInsets( top: 0, left: 0, bottom: newFrame.height, right: 0 )
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
        }
    }
}

extension CitiesPickerVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        citiesPickerViewModel.filter(query: searchController.searchBar.text!)
    }
}

extension CitiesPickerVC: UITableViewDataSource {
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

extension CitiesPickerVC: CitiesPickerViewModelDelegate {
    func timezoneListChanged(timezones: [[TimeZone]]) {
        tableView.reloadData()
    }
}

extension CitiesPickerVC: UITableViewDelegate {
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        citiesPickerViewModel.isSearching ? [] : citiesPickerViewModel.sectionsData.titles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
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
        returnedView.backgroundColor = UIColor(displayP3Red: 50/255, green: 50/255, blue: 52/255, alpha: 1)
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

extension CitiesPickerVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
}
