//
//  EditLabelViewController.swift
//  Clock
//
//  Created by Hardijs on 20/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class EditLabelVC: UIViewController {
    
    private let labelEditTextField = TintTextField()
    
    private var onLabelEditingCompleted: ((String) -> Void)? = nil
    
    override func viewDidLoad() {
        setupNavigationBar()
        view.backgroundColor = UIColor(named: "Secondary")
        setupTextField()
    }
    
    private func setupNavigationBar() {
        title = NSLocalizedString("Label", comment: "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        onLabelEditingCompleted?(labelEditTextField.text ?? "")
    }
    
    func editLabel(_ text: String, onCompleted: ((String) -> Void)? = nil) {
        labelEditTextField.text = text
        onLabelEditingCompleted = onCompleted
    }
    
    private func setupTextField() {
        labelEditTextField.delegate = self
        labelEditTextField.returnKeyType = UIReturnKeyType.done
        labelEditTextField.clearButtonColor = .white
        labelEditTextField.textColor = .white
        labelEditTextField.borderStyle = UITextField.BorderStyle.line
        labelEditTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        labelEditTextField.backgroundColor = UIColor(named: "Primary")
        labelEditTextField.becomeFirstResponder()
        view.addSubview(labelEditTextField)
        labelEditTextField.translatesAutoresizingMaskIntoConstraints = false
        labelEditTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        labelEditTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        labelEditTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        labelEditTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: labelEditTextField.frame.height))
        labelEditTextField.leftView = paddingView
        labelEditTextField.leftViewMode = .always
        labelEditTextField.tintColor = .orange
    }
}

extension EditLabelVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationController?.popViewController(animated: true)
        return true
    }
    
}
