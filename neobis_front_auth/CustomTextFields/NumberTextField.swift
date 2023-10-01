//
//  NumberTextField.swift
//  neobis_front_auth
//
//  Created by Askar Soronbekov

import UIKit

class NumberTextField: UITextField {
    
    private var placeholderLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPlaceholderLabel()
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePlaceholderVisibility()
    }
    
    private func setupPlaceholderLabel() {
        placeholderLabel = UILabel()
        placeholderLabel?.font = font
        placeholderLabel?.textColor = UIColor.placeholderText
        placeholderLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(placeholderLabel!)
        
        NSLayoutConstraint.activate([
            placeholderLabel!.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            placeholderLabel!.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            placeholderLabel!.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            placeholderLabel!.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    private func updatePlaceholderVisibility() {
        if let text = text, text.isEmpty {
            placeholderLabel?.isHidden = false
        } else {
            placeholderLabel?.isHidden = true
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        updatePlaceholderVisibility()
    }
    
}

