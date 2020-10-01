//
//  AddEditAlarmMenuCell.swift
//  Clock
//
//  Created by Hardijs on 19/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class AddEditAlarmMenuCell: UITableViewCell {
        
    lazy var chevronView: UIView = {
        let image = UIImage(systemName: "chevron.right")
        let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:10, height:13))
        accessory.image = image
        accessory.tintColor = UIColor.systemGray
        
        return accessory
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        selectedBackgroundView = bgColorView
        backgroundColor = UIColor(named: "MenuItem")
        textLabel?.textColor = .white
        detailTextLabel?.textColor = .systemGray
    }
}


