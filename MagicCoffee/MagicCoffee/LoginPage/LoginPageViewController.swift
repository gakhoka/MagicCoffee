//
//  LoginPageViewController.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 12.01.25.
//

import UIKit
import SwiftUI

class LoginPageViewController: UIViewController {
    
    private let textFieldCenter = CustomTextField()
    
    private let leftBarButton = UIButton()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        return stackView
    }()
    
    private lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.create(text: "Sign in",font: 24)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.create(text: "Welcome back", textColor: .systemGray2, font: 16)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        placeViews()
        setupConstraints()
        stackViewSetup()
        leftBarButtonConfig()
    }
    
    private func placeViews() {
        view.addSubview(signInLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(textFieldsStackView)
    }
    
    private func leftBarButtonConfig() {
        view.addSubview(leftBarButton)
        leftBarButton.translatesAutoresizingMaskIntoConstraints = false
        leftBarButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        leftBarButton.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        leftBarButton.addAction(UIAction(handler: { [weak self] action in
            self?.backButtonTapped()
        }), for: .touchUpInside)
    }
    
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func stackViewSetup() {
        let emailTextField = textFieldCenter.createTextField(placeholder: "Enter email", imageName: "Message")
        let passwordTextField = textFieldCenter.createTextField(placeholder: "Enter password", imageName: "Lock", showPasswordIcon: true)
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            signInLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            subtitleLabel.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 20),
            subtitleLabel.leftAnchor.constraint(equalTo: signInLabel.leftAnchor),
            
            textFieldsStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 50),
            textFieldsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            textFieldsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
    }
}

struct viewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = LoginPageViewController
    
    
    func makeUIViewController(context: Context) -> LoginPageViewController {
        LoginPageViewController()
    }
    
    func updateUIViewController(_ uiViewController: LoginPageViewController, context: Context) {
        
    }
}

struct viewController_Previews: PreviewProvider {
    static var previews: some View {
        viewControllerRepresentable()
    }
}
