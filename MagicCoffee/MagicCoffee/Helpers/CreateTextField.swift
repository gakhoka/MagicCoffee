//
//  CreateTextField.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 12.01.25.
//

import UIKit

class CustomTextField {
    
    func createTextField(placeholder: String, imageName: String, showPasswordIcon: Bool = false) -> (container: UIView, textField: UITextField) {
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .systemGray2
        dividerView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        container.addSubview(dividerView)
        
        let bottomDivider = UIView()
        bottomDivider.translatesAutoresizingMaskIntoConstraints = false
        bottomDivider.widthAnchor.constraint(equalToConstant: 100).isActive = true
        bottomDivider.backgroundColor = .systemGray2
        bottomDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        container.addSubview(bottomDivider)
        
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: imageName)
        iconImageView.tintColor = .gray
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(iconImageView)
        
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(textField)
        
        var eyeButton: UIButton?
        if showPasswordIcon {
            eyeButton = UIButton(type: .system)
            eyeButton?.setImage(UIImage(named: "Eye"), for: .normal)
            eyeButton?.tintColor = .black
            eyeButton?.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(eyeButton!)
            
            eyeButton?.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        }
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            iconImageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            dividerView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            dividerView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            textField.leftAnchor.constraint(equalTo: dividerView.rightAnchor, constant: 10),
            textField.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            bottomDivider.leftAnchor.constraint(equalTo: iconImageView.leftAnchor),
            bottomDivider.rightAnchor.constraint(equalTo: textField.rightAnchor),
            bottomDivider.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
            
         
        ])
        
        if let eyeButton = eyeButton {
            NSLayoutConstraint.activate([
                eyeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
                eyeButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                eyeButton.widthAnchor.constraint(equalToConstant: 30),
                eyeButton.heightAnchor.constraint(equalToConstant: 26)
            ])
        }
        return (container, textField)
    }
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        guard let containerView = sender.superview else { return }
        guard let textField = containerView.subviews.compactMap({ $0 as? UITextField }).first else { return }
        
        if textField.isSecureTextEntry {
            textField.isSecureTextEntry = false
            sender.setImage(UIImage(named: "Eye"), for: .normal)
        } else {
            textField.isSecureTextEntry = true
            sender.setImage(UIImage(named: "Eyeoff"), for: .normal)
        }
    }
}

