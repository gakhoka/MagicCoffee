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
   
    private lazy var newMemberLabel: UILabel = {
        let label = UILabel()
        label.create(text: "New member?", textColor: .systemGray2, font: 14)
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.create(title: "Sign Up")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.create(image: "arrow.right", backgroundColor: .navyGreen)
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.create(title: "Forgot Password ?")
        return button
    }()
    
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
        label.create(text: "Welcome back", textColor: .systemGray2, font: 14)
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
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(newMemberLabel)
        view.addSubview(signUpButton)
    }
    
    private func leftBarButtonConfig() {
        configureLeftBarButton(icon: "arrow.left", action: { [weak self] in
            self?.backButtonTapped()
        })
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
            textFieldsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 20),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            //MARK: SHECVALE
            loginButton.bottomAnchor.constraint(equalTo: newMemberLabel.topAnchor, constant: -50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 50),
            
            newMemberLabel.leftAnchor.constraint(equalTo: signInLabel.leftAnchor),
            newMemberLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            signUpButton.leftAnchor.constraint(equalTo: newMemberLabel.rightAnchor, constant: 5),
            signUpButton.centerYAnchor.constraint(equalTo: newMemberLabel.centerYAnchor)
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
