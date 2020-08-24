//
//  TunePickerButton.swift
//  Clock
//
//  Created by Hardijs on 24/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class TunePickerButton: UIButton {
    
    private var tuneName: UILabel = {
       let label = UILabel()
        label.text = ""
        label.textColor = .gray
        return label
    }()
    
    private var chevronView: UIImageView = {
        let image = UIImage(systemName: "chevron.right")
        let view: UIImageView = UIImageView(image: image)
        view.tintColor = .gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupChevronImageView()
        setupTuneNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupChevronImageView() {
        addSubview(chevronView)
        
        chevronView.translatesAutoresizingMaskIntoConstraints = false
        chevronView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        chevronView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        chevronView.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    private func setupTuneNameLabel() {
        addSubview(tuneName)
        
        tuneName.translatesAutoresizingMaskIntoConstraints = false
        tuneName.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        tuneName.trailingAnchor.constraint(equalTo: chevronView.leadingAnchor, constant: -7).isActive = true
    }
    
    func setTuneName(_ name: String) {
        tuneName.text = name
    }
}
