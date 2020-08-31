//
//  StopwatchViewController.swift
//  Clock
//
//  Created by Hardijs on 15/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    private lazy var clockFaceCollectionViewController: StopwatchFaceCollectionViewController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = StopwatchFaceCollectionViewController(collectionViewLayout: layout)
        return vc
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(named: "Secondary")
        setupClocks()
    }
    
    private func setupClocks() {
        addChild(clockFaceCollectionViewController)
        view.addSubview(clockFaceCollectionViewController.view)
        clockFaceCollectionViewController.didMove(toParent: self)
        clockFaceCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        clockFaceCollectionViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        clockFaceCollectionViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        clockFaceCollectionViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        clockFaceCollectionViewController.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
