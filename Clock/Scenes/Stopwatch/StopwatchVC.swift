//
//  StopwatchViewController.swift
//  Clock
//
//  Created by Hardijs on 15/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class StopwatchVC: UIViewController {
    
    private lazy var clockFaceCollectionViewController: StopwatchFaceCollectionVC = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = StopwatchFaceCollectionVC(collectionViewLayout: layout)
        return vc
    }()
    
    private var stopwatchViewModel: StopwatchVM = StopwatchVM()
    
    private var lapButton: UIButton = UIButton()
    
    private var startButton: UIButton = UIButton()
    
    private var stopButton: UIButton = UIButton()
    
    private var resetButton: UIButton = UIButton()
    
    private var tableView: UITableView = UITableView()
    
    private var baseScrollView = UIScrollView()
    
    private var contentView = UIView()
    
    private func setupScrollView() {
        view.addSubview(baseScrollView)
        baseScrollView.pin(to: view)
        baseScrollView.addSubview(contentView)
        contentView.pin(to: baseScrollView)
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        setupScrollView()
        view.backgroundColor = UIColor(named: "Secondary")
        stopwatchViewModel.delegate = self
        setupClocks()
        setupButtons()
        setupTableView()
    }
    
    @objc func lapButtonPressed() {
        stopwatchViewModel.addLap()
    }
    
    @objc func startButtonPressed() {
        stopwatchViewModel.startStopwatch()
    }
    
    @objc func stopButtonPressed() {
        stopwatchViewModel.stopStopwatch()
    }
    
    @objc func resetButtonPressed() {
        stopwatchViewModel.resetStopwatch()
    }
    
    private func setupButtons() {
        setupLapButton()
        setupStartButton()
        setupStopButton()
        setupResetButton()
    }
    
    private func setupTableView() {
        tableView.register(StopwatchCell.self, forCellReuseIdentifier: "StopwatchCell")
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.delegate = self
        tableView.separatorColor = UIColor.gray.withAlphaComponent(0.3)
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        contentView.addSubview(tableView)
        view.layoutIfNeeded()
        let tableHeight = view.frame.height - clockFaceCollectionViewController.view.frame.height - ((tabBarController?.tabBar.frame.height) ?? 0) - 0
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: clockFaceCollectionViewController.view.bottomAnchor, constant: 40).isActive = true
        tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: tableHeight).isActive = true
    }
    
    private func setupClocks() {
        addChild(clockFaceCollectionViewController)
        contentView.addSubview(clockFaceCollectionViewController.view)
        clockFaceCollectionViewController.didMove(toParent: self)
        clockFaceCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        clockFaceCollectionViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        clockFaceCollectionViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        clockFaceCollectionViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        clockFaceCollectionViewController.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func setupStartButton() {
        // Configure button
        startButton.isHidden = stopwatchViewModel.stopwatchState == .running ? true : false
        startButton.setTitle(NSLocalizedString("Start", comment: ""), for: .normal)
        startButton.setTitleColor(.green, for: .normal)
        startButton.layer.cornerRadius = 38
        startButton.backgroundColor = UIColor(red: 26/255, green: 54/255, blue: 31/255, alpha: 1)
        startButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        startButton.addPaddedStroke(paddingColor: UIColor(named: "Secondary")!, strokeColor: startButton.backgroundColor!, borderWidth: 2)
        
        // Add button via stroke to main view
        contentView.addSubview(startButton)
        
        // Contraints
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.topAnchor.constraint(equalTo: clockFaceCollectionViewController.view.bottomAnchor, constant: -60).isActive = true
        startButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setupStopButton() {
        // Configure button
        stopButton.isHidden = stopwatchViewModel.stopwatchState != .running ? true : false
        stopButton.setTitle(NSLocalizedString("Stop", comment: ""), for: .normal)
        stopButton.setTitleColor(.red, for: .normal)
        stopButton.layer.cornerRadius = 38
        stopButton.backgroundColor = UIColor(red: 61/255, green: 22/255, blue: 19/255, alpha: 1)
        stopButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)
        stopButton.addTarget(self, action: #selector(stopButtonPressed), for: .touchUpInside)
        stopButton.addPaddedStroke(paddingColor: UIColor(named: "Secondary")!, strokeColor: stopButton.backgroundColor!, borderWidth: 2)
        
        // Add button via stroke to main view
        contentView.addSubview(stopButton)
        
        // Contraints
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        
        stopButton.topAnchor.constraint(equalTo: clockFaceCollectionViewController.view.bottomAnchor, constant: -60).isActive = true
        stopButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        stopButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        stopButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setupResetButton() {
        resetButton.isHidden = stopwatchViewModel.stopwatchState == .stopped ? false : true
        resetButton.setTitle(NSLocalizedString("Reset", comment: ""), for: .normal)
        resetButton.setTitleColor(.gray, for: .normal)
        resetButton.layer.cornerRadius = 38
        resetButton.backgroundColor = UIColor(named: "Primary")
        resetButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)
        resetButton.addPaddedStroke(paddingColor: UIColor(named: "Secondary")!, strokeColor: resetButton.backgroundColor!, borderWidth: 2)
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        
        contentView.addSubview(resetButton)
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        resetButton.topAnchor.constraint(equalTo: clockFaceCollectionViewController.view.bottomAnchor, constant: -60).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setupLapButton() {
        lapButton.isEnabled = stopwatchViewModel.stopwatchState == .running ? true : false
        lapButton.isHidden = stopwatchViewModel.stopwatchState == .stopped ? true : false
        lapButton.setTitle(NSLocalizedString("Lap", comment: ""), for: .normal)
        lapButton.setTitleColor(.gray, for: .normal)
        lapButton.layer.cornerRadius = 38
        lapButton.backgroundColor = UIColor(named: "Primary")
        lapButton.setBackgroundColor(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5), forState: .highlighted)
        lapButton.addPaddedStroke(paddingColor: UIColor(named: "Secondary")!, strokeColor: lapButton.backgroundColor!, borderWidth: 2)
        lapButton.addTarget(self, action: #selector(lapButtonPressed), for: .touchUpInside)
        
        contentView.addSubview(lapButton)
        
        lapButton.translatesAutoresizingMaskIntoConstraints = false
        lapButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        lapButton.topAnchor.constraint(equalTo: clockFaceCollectionViewController.view.bottomAnchor, constant: -60).isActive = true
        lapButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        lapButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension StopwatchVC: UITableViewDelegate {
    
}

extension StopwatchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stopwatchViewModel.laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StopwatchCell", for: indexPath) as! StopwatchCell

        cell.lapLabel.text = "\(NSLocalizedString("Lap", comment: "")) \( stopwatchViewModel.laps.count - indexPath.row)"
        let cellViewModel =  stopwatchViewModel.laps[indexPath.row]
        cell.setup(with: cellViewModel)
        return cell
    }
}

extension StopwatchVC: StopwatchVMDelegate {
    func lapsChanged() {
        tableView.reloadData()
    }
    
    
    func stopwatchTimeChanged(timeString: String) {
        clockFaceCollectionViewController.digitalClockCell?.setTime(string: timeString)
    }
    
    func stopwatchStateChanged(state: StopwatchState) {
        switch state {
        case .idle:
            startButton.isHidden = false
            stopButton.isHidden = true
            resetButton.isHidden = true
            lapButton.isHidden = false
            lapButton.isEnabled = false
        case .running:
            startButton.isHidden = true
            stopButton.isHidden = false
            resetButton.isHidden = true
            lapButton.isHidden = false
            lapButton.isEnabled = true
        case .stopped:
            startButton.isHidden = false
            stopButton.isHidden = true
            resetButton.isHidden = false
            lapButton.isHidden = true
        }
    }
}
