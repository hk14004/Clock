//
//  TuneSelectionViewController.swift
//  Clock
//
//  Created by Hardijs on 24/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class TuneSelectionViewController: UIViewController {

    private var cancelButton: UIButton = UIButton()
    
    private var titleLabel: UILabel = UILabel()
    
    private var setButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Primary")
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "Primary")
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "When Timer Ends"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Set", style: .done, target: self, action: #selector(dismissSelf))
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
}
