//
//  EditLabelViewController.swift
//  Clock
//
//  Created by Hardijs on 20/09/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class EditLabelViewController: UIViewController {
    
    private let labelEditTextField = TintTextField()
    
    private var onLabelEditingCompleted: ((String) -> Void)? = nil
    
    override func viewDidLoad() {
        setupNavigationBar()
        view.backgroundColor = UIColor(named: "Secondary")
        setupTextField()
    }
    
    private func setupNavigationBar() {
            title = "Label"
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

extension EditLabelViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }

}
