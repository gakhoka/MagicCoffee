//
//  DigitEntryViewController.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//


import UIKit

class FourDigitEntryView: UIView, UITextFieldDelegate {
    private let digitLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    private let hiddenTextField = UITextField()
    
    var onCodeComplete: ((String) -> Void)? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: digitLabels)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 75)
        ])

        for label in digitLabels {
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 24, weight: .light)
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.clear.cgColor
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            label.backgroundColor = .systemGray5
            label.widthAnchor.constraint(equalToConstant: 50).isActive = true
            label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        }
    
        hiddenTextField.keyboardType = .numberPad
        hiddenTextField.textContentType = .oneTimeCode
        hiddenTextField.delegate = self
        hiddenTextField.tintColor = .red
        hiddenTextField.textColor = .clear
        addSubview(hiddenTextField)
 
        hiddenTextField.translatesAutoresizingMaskIntoConstraints = false
        hiddenTextField.isAccessibilityElement = true
        NSLayoutConstraint.activate([
            hiddenTextField.topAnchor.constraint(equalTo: topAnchor),
            hiddenTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            hiddenTextField.widthAnchor.constraint(equalToConstant: 0),
            hiddenTextField.heightAnchor.constraint(equalToConstant: 0)
        ])
 
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(focusTextField))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func focusTextField() {
        hiddenTextField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count <= 4 {
            updateDigitLabels(for: newText)
            return true
        }
        return false
    }
    
    private func updateDigitLabels(for text: String) {
        for (index, label) in digitLabels.enumerated() {
            if index < text.count {
                let charIndex = text.index(text.startIndex, offsetBy: index)
                label.text = String(text[charIndex])
            } else {
                label.text = ""
            }
        }
        
        if text.count == 4 {
            onCodeComplete?(text)
            hiddenTextField.resignFirstResponder()
        }
    }
}

