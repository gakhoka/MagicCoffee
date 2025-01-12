//
//  SignupViewController.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 12.01.25.
//

import UIKit
import SwiftUI

class SignupViewController: UIViewController {
    
    private let textFieldCenter = CustomTextField()

    
    private lazy var memberLabel: UILabel = {
        let label = UILabel()
        label.create(text: "Alredy a member?", textColor: .systemGray2, font: 14)
        return label
    }()
    
    private lazy var signinButton: UIButton = {
        let button = UIButton()
        button.create(title: "Sign in")
        button.addAction(UIAction(handler: { [weak self] action  in
            self?.navigateTologinPage()
        }), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.create(image: "arrow.right", backgroundColor: .navyGreen)
        return button
    }()
    
    private lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.create(text: "By signing up you agree with our Terms of Use", font: 14)
        return label
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.configure()
        return stackView
    }()
    
    private lazy var signupLabel: UILabel = {
        let label = UILabel()
        label.create(text: "Sign up",font: 24)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.create(text: "Create an account here", textColor: .systemGray2, font: 14)
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
        leftBarButtonConfig()
        configureStackView()
    }
    
    private func leftBarButtonConfig() {
        configureLeftBarButton(icon: "arrow.left", action: { [weak self] in
            self?.navigateTologinPage()
        })
    }
    
    private func navigateTologinPage() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureStackView() {
        let usernameTextField = textFieldCenter.createTextField(placeholder: "Username", imageName: "Profile")
        let mobileNumberTextField = textFieldCenter.createTextField(placeholder: "Mobile Number", imageName: "smartphone")
        let emailTextField = textFieldCenter.createTextField(placeholder: "Email address", imageName: "Message")
        let passwordTextField = textFieldCenter.createTextField(placeholder: " Password", imageName: "Lock", showPasswordIcon: true)
        
        textFieldsStackView.addMultipleViews(usernameTextField, mobileNumberTextField, emailTextField, passwordTextField)
    }
    
    private func placeViews() {
        view.addSubview(signupLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(termsLabel)
        view.addSubview(loginButton)
        view.addSubview(textFieldsStackView)
        view.addSubview(memberLabel)
        view.addSubview(signinButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        signupLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
        signupLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
        
        subtitleLabel.topAnchor.constraint(equalTo: signupLabel.bottomAnchor, constant: 20),
        subtitleLabel.leftAnchor.constraint(equalTo: signupLabel.leftAnchor),
        
        textFieldsStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 50),
        textFieldsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
        textFieldsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
        
        termsLabel.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 20),
        termsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
        loginButton.bottomAnchor.constraint(equalTo: memberLabel.topAnchor, constant: -50),
        loginButton.heightAnchor.constraint(equalToConstant: 50),
        loginButton.widthAnchor.constraint(equalToConstant: 50),
        
        memberLabel.leftAnchor.constraint(equalTo: signupLabel.leftAnchor),
        memberLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        
        signinButton.leftAnchor.constraint(equalTo: memberLabel.rightAnchor, constant: 5),
        signinButton.centerYAnchor.constraint(equalTo: memberLabel.centerYAnchor)
        ])
    }
}

struct signUpviewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = SignupViewController
    
    
    func makeUIViewController(context: Context) -> SignupViewController {
        SignupViewController()
    }
    
    func updateUIViewController(_ uiViewController: SignupViewController, context: Context) {
        
    }
}

struct signUpviewControler_Previews: PreviewProvider {
    static var previews: some View {
        signUpviewControllerRepresentable()
    }
}
