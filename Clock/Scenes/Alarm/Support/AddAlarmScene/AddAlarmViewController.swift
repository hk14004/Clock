//
//  AddAlarmViewController.swift
//  Clock
//
//  Created by Hardijs on 16/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AddAlarmViewController: UIViewController {
    
    private let addAlarmViewModel = AddAlarmViewModel()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "Secondary")
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Add Alarm"
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        // Navigation items
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        navigationItem.rightBarButtonItem = save
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.leftBarButtonItem = cancel
    }
    
    @objc func saveTapped() {
        // TODO: Perform save
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
}
