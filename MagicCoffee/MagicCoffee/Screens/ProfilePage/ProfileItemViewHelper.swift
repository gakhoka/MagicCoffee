//
//  ProfileItemViewHelper.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 31.01.25.
//


import UIKit

class ProfileItemViewHelper {
    
     func createProfileItemView(icon: String, title: String, value: String, toggleEdit: @escaping (UIButton) -> Void) -> UIView {
        let containerView = UIView()
         containerView.backgroundColor = .lightGrayBackground
        containerView.layer.cornerRadius = 10
        
        let iconImage = UIImageView()
        iconImage.image = UIImage(systemName: icon)
        iconImage.tintColor = .black
        iconImage.contentMode = .scaleAspectFit
        
        let labelsStack = UIStackView()
        labelsStack.axis = .vertical
        labelsStack.spacing = 10
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .systemGray
        
        let valueTextField = UITextField()
        valueTextField.text = value
        valueTextField.font = .systemFont(ofSize: 16)
        valueTextField.borderStyle = .none
        valueTextField.autocapitalizationType = .none
        valueTextField.isEnabled = false

        let editButton = UIButton()
        editButton.setImage(UIImage(named: "Edit"), for: .normal)
        editButton.tintColor = .systemGray
        editButton.addAction(UIAction(handler: { action in
            toggleEdit(editButton) 
        }), for: .touchUpInside)

        
        containerView.addSubview(iconImage)
        containerView.addSubview(labelsStack)
        containerView.addSubview(editButton)
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(valueTextField)
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 80),
            
            iconImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            iconImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 30),
            iconImage.heightAnchor.constraint(equalToConstant: 30),
            
            labelsStack.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 15),
            labelsStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            labelsStack.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -10),
            
            editButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            editButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 30),
            editButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return containerView
    }
}
