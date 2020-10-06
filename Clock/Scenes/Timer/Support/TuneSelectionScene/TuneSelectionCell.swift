//
//  TuneSelectionCell.swift
//  Clock
//
//  Created by Hardijs on 27/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

extension TuneSelectionCell: TuneCellViewModelDelegate {
    func defaultValueChanged(isDefault: Bool) {
        if isDefault {
            setSelectedd()
        } else {
            setUnSelectedd()
        }
    }
}

class TuneSelectionCell: UITableViewCell {
    
    static let identifier = "TuneSelectCell"
    
    private var selectionImage: UIImageView = UIImageView(image: UIImage(systemName: "checkmark"))
    
    private var tuneName: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = UIColor(named: "Primary")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: TuneCellViewModel) {
        self.tuneName.text = viewModel.tune.name
        viewModel.delegate = self
        defaultValueChanged(isDefault: viewModel.isdefault)
    }
    
    private func setupViews() {
        setupCheckImage()
        setupTuneNameLabel()
    }
    
    private func setupCheckImage() {
        selectionImage.tintColor = .orange
        selectionImage.isHidden = true
        contentView.addSubview(selectionImage)
        selectionImage.translatesAutoresizingMaskIntoConstraints = false
        selectionImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        selectionImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        selectionImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        selectionImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setupTuneNameLabel() {
        tuneName.textColor = .white
        contentView.addSubview(tuneName)
        tuneName.translatesAutoresizingMaskIntoConstraints = false
        tuneName.leadingAnchor.constraint(equalTo: selectionImage.trailingAnchor, constant: 15).isActive = true
        tuneName.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        tuneName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
    }
    
    func setSelectedd() {
        selectionImage.isHidden = false
    }
    
    func setUnSelectedd() {
        selectionImage.isHidden = true
    }
}
