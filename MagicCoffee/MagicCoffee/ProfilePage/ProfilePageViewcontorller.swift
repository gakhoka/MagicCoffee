//
//  ProfilePageViewcontorller.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//


import SwiftUI
import UIKit

class ProfilePageViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureViewModel()
        viewModel.fetchUserProfile()
    }
    
    private func configureViewModel() {
        viewModel.updateHandler = { [weak self] in
            self?.setupProfileItems()
        }
    }
    
    private func setupUI() {
        setupStackView()
    }
    
    private func createProfileItemView(icon: String, title: String, value: String) -> UIView {
        let containerView = UIView()
        
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: icon)
        iconImage.tintColor = .systemGray
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
        editButton.addAction(UIAction(handler: {[weak self] action in
            self?.toggleEdit(editButton)
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
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ])
    }
    
    private func setupProfileItems() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let items = [
            ("Profile", "Name", viewModel.username),
            ("Message", "Email", viewModel.email),
            ("Lock", "Password", "*********")
        ]
        
        items.forEach { icon, title, value in
            let itemView = self.createProfileItemView(icon: icon, title: title, value: value)
            self.stackView.addArrangedSubview(itemView)
        }
    }
    
    
    private func toggleEdit(_ sender: UIButton) {
        guard let containerView = sender.superview,
              let labelsStack = containerView.subviews.first(where: { $0 is UIStackView }) as? UIStackView,
              let titleLabel = labelsStack.arrangedSubviews.first as? UILabel,
              let valueTextField = labelsStack.arrangedSubviews.last as? UITextField else { return }
        
        if valueTextField.isEnabled {
            sender.setImage(UIImage(named: "Edit"), for: .normal)
            valueTextField.isEnabled = false
            
            if titleLabel.text == "Name" {
                viewModel.updateProfile(username: valueTextField.text ?? "", email: viewModel.email) { _ in }
            } else if titleLabel.text == "Email" {
                viewModel.updateProfile(username: viewModel.username, email: valueTextField.text ?? "") { _ in }
            } else if titleLabel.text == "Password" {
                viewModel.updatePassword(newPassword: valueTextField.text ?? "")
                valueTextField.text = String(repeating: "*", count: valueTextField.text?.count ?? 0)
                valueTextField.isSecureTextEntry = true
            }
        } else {
            sender.setImage(UIImage(named: "checked"), for: .normal)
            valueTextField.isEnabled = true
            if titleLabel.text == "Password" {
                        valueTextField.text = ""
                valueTextField.isSecureTextEntry = false
                    }
            valueTextField.becomeFirstResponder()
        }
    }
}

struct ProfileviewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ProfilePageViewController
    
    
    func makeUIViewController(context: Context) -> ProfilePageViewController {
        ProfilePageViewController()
    }
    
    func updateUIViewController(_ uiViewController: ProfilePageViewController, context: Context) {
        
    }
}

struct ProfileviewController_Previews: PreviewProvider {
    static var previews: some View {
        ProfileviewControllerRepresentable()
    }
}
