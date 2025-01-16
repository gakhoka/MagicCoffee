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
    
    private var emailField: UITextField?
    private var passwordField: UITextField?
   
    private lazy var newMemberLabel: UILabel = {
        let label = UILabel()
        label.create(text: "New member?", textColor: .systemGray2, font: 14)
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.create(title: "Sign Up")
        button.addAction(UIAction { [weak self] action in
            self?.signUpButtonTapped()
        }, for: .touchUpInside)
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
        button.addAction(UIAction(handler: { [weak self] action in
            self?.navigateToForgotPassPage()
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.configure()
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
    
    private func navigateToForgotPassPage() {
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    private func signUpButtonTapped() {
        navigationController?.pushViewController(SignupViewController(), animated: true)
    }
    
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func stackViewSetup() {
        let (emailContainer, emailTextField) = textFieldCenter.createTextField(placeholder: "Email address", imageName: "Message")
        let (passwordContainer, passwordTextField) = textFieldCenter.createTextField(placeholder: "Email address", imageName: "Lock", showPasswordIcon: true)
        
        self.emailField = emailTextField
        self.passwordField = passwordTextField
        
        textFieldsStackView.addMultipleViews(emailContainer, passwordContainer )
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
