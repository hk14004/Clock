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
    
    private var lapButton: UIButton = UIButton()
    
    private var startButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(named: "Secondary")
        setupClocks()
        setupLapButton()
        setupStartButton()
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
    
    private func setupStartButton() {
        // Configure button
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.green, for: .normal)
        startButton.layer.cornerRadius = 38
        startButton.backgroundColor = UIColor(red: 26/255, green: 54/255, blue: 31/255, alpha: 1)
        startButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)
        //startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        startButton.addPaddedStroke(paddingColor: UIColor(named: "Secondary")!, strokeColor: startButton.backgroundColor!, borderWidth: 2)
        
        // Add button via stroke to main view
        view.addSubview(startButton)
        
        // Contraints
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.topAnchor.constraint(equalTo: clockFaceCollectionViewController.view.bottomAnchor, constant: -60).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setupLapButton() {
        lapButton.setTitle("Lap", for: .normal)
        lapButton.setTitleColor(.gray, for: .normal)
        lapButton.layer.cornerRadius = 38
        lapButton.backgroundColor = UIColor(named: "Primary")
        lapButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)

        lapButton.addPaddedStroke(paddingColor: UIColor(named: "Secondary")!, strokeColor: lapButton.backgroundColor!, borderWidth: 2)
        
        
        view.addSubview(lapButton)
        
        lapButton.translatesAutoresizingMaskIntoConstraints = false
        lapButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        lapButton.topAnchor.constraint(equalTo: clockFaceCollectionViewController.view.bottomAnchor, constant: -60).isActive = true
        lapButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
         lapButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
