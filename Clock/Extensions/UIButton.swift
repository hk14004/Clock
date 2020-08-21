//
//  UIButton.swift
//  Clock
//
//  Created by Hardijs on 18/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
        self.clipsToBounds = true
    }
    
    func addPaddedStroke(paddingColor: UIColor, strokeColor: UIColor, borderWidth: CGFloat = 2) {
        /// Add stroke
        layer.borderColor = strokeColor.cgColor
        layer.borderWidth = borderWidth
        
        /// Add padded stroke
        let strokeView = UIView()
        strokeView.backgroundColor = .clear
        strokeView.layer.borderColor = paddingColor.cgColor
        strokeView.layer.borderWidth = borderWidth
        strokeView.layer.cornerRadius = layer.cornerRadius - borderWidth
        strokeView.isUserInteractionEnabled = false

        /// Add start button as subview of stroke view
        addSubview(strokeView)
        
        // Contraints
        translatesAutoresizingMaskIntoConstraints = false
        strokeView.translatesAutoresizingMaskIntoConstraints = false
        /// Pin  start button to stroke view with a bit of padding
        strokeView.topAnchor.constraint(equalTo: topAnchor, constant: borderWidth).isActive = true
        strokeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: borderWidth).isActive = true
        strokeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -borderWidth).isActive = true
        strokeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -borderWidth).isActive = true

    }
}
