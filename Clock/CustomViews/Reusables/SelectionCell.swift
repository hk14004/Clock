//
//  TuneSelectionCell.swift
//  Clock
//
//  Created by Hardijs on 27/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

protocol SelectionCellVMDelegate: class {
    func stateChanged(selected: Bool)
}

extension SelectionCell: SelectionCellVMDelegate {
    func stateChanged(selected: Bool) {
        selected ? setSelected() : setUnSelected()
    }
}

class SelectionCell: UITableViewCell {
    
    static let identifier = "SelectCell"
    
    private(set) var selectionImage: UIImageView = UIImageView(image: UIImage(systemName: "checkmark"))
    
    private(set) var itemName: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = UIColor(named: "Primary")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(itemName: String, isSelected: Bool) {
        self.itemName.text = itemName
        stateChanged(selected: isSelected)
    }
    
    private func setupViews() {
        setupCheckImage()
        setupItemNameLabel()
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
    
    private func setupItemNameLabel() {
        itemName.textColor = .white
        contentView.addSubview(itemName)
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemName.leadingAnchor.constraint(equalTo: selectionImage.trailingAnchor, constant: 15).isActive = true
        itemName.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0).isActive = true
        itemName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
    }
    
    func setSelected() {
        selectionImage.isHidden = false
    }
    
    func setUnSelected() {
        selectionImage.isHidden = true
    }
}
