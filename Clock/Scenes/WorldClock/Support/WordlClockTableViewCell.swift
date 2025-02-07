//
//  WordlClockTableViewCell.swift
//  Clock
//
//  Created by Hardijs on 08/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class WordlClockTableViewCell: UITableViewCell {
    
    private var cityNameLabel: UILabel = UILabel()
    
    private var timeOffsetLabel: UILabel = UILabel()
    
    private(set) var timeLabel: UILabel = UILabel()
    
    private var viewModel: WordlClockTableViewCellModel? {
        didSet {
            oldValue?.wordlClockTableViewCell = nil
            viewModel?.wordlClockTableViewCell = self
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTime(_ time: Date, timezone: TimeZone) {
        let seconds = timezone.secondsFromGMT() - TimeZone.current.secondsFromGMT()
        let hours = seconds/3600
        let minutes = abs(seconds/60) % 60
        timeOffsetLabel.text = String(format: "%+.2d:%.2d", hours, minutes)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = timezone
        timeLabel.text = dateFormatter.string(from: viewModel?.currentTime ?? Date())
    }
    
    private func setup() {
        backgroundColor = .clear
        setupTimeOffsetLabel()
        setupCityNameLabel()
        setupTimeLabel()
        timeOffsetLabel.bottomAnchor.constraint(equalTo: cityNameLabel.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    }

    func setup(with viewModel: WordlClockTableViewCellModel) {
        self.viewModel = viewModel
        cityNameLabel.text = "\(viewModel.timezone.identifier.split(separator: "/").last ?? "")".replacingOccurrences(of: "_", with: " ")
        setTime(viewModel.currentTime, timezone: viewModel.timezone)
        timeLabel.isHidden = viewModel.hideTime
    }
    
    private func setupTimeLabel() {
        timeLabel.textColor = .white
        timeLabel.font = timeLabel.font.withSize(50)
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
    }
    
    private func setupCityNameLabel() {
        cityNameLabel.textColor = .white
        cityNameLabel.font = cityNameLabel.font.withSize(30)
        contentView.addSubview(cityNameLabel)
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        cityNameLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
    }
    
    private func setupTimeOffsetLabel() {
        timeOffsetLabel.textColor = .gray
        timeOffsetLabel.font = cityNameLabel.font.withSize(15)
        contentView.addSubview(timeOffsetLabel)
        timeOffsetLabel.translatesAutoresizingMaskIntoConstraints = false
        timeOffsetLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        timeOffsetLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
    }
}
