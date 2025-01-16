//
//  ForgotPasswordViewController.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 12.01.25.
//
import SwiftUI
import UIKit

class ForgotPasswordViewController: UIViewController {
    
  //  private let textFieldCenter = CustomTextField()
    
    private lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.create(text: "Forgot password ? ",font: 24)
        return label
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.configure()
        return stackView
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.create(text: "Enter your email address", textColor: .systemGray2, font: 14)
        return label
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.create(image: "arrow.right", backgroundColor: .navyGreen)
        button.addAction(UIAction(handler: { [weak self] action in
            self?.navigateToVerificationPage()
        }), for: .touchUpInside)
        return button
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
    
    private func placeViews() {
        view.addSubview(forgotPasswordLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(textFieldsStackView)
        view.addSubview(sendButton)
    }
    
    private func navigateToVerificationPage() {
        navigationController?.pushViewController(VerificationViewController(), animated: true)
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
//        let emailTextField = textFieldCenter.createTextField(placeholder: "Email address", imageName: "Message")
        
     //   textFieldsStackView.addMultipleViews(emailTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            forgotPasswordLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            forgotPasswordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            subtitleLabel.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 20),
            subtitleLabel.leftAnchor.constraint(equalTo: forgotPasswordLabel.leftAnchor),
            
            textFieldsStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 50),
            textFieldsStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            textFieldsStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
            sendButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}


struct ForgotviewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ForgotPasswordViewController
    
    
    func makeUIViewController(context: Context) -> ForgotPasswordViewController {
        ForgotPasswordViewController()
    }
    
    func updateUIViewController(_ uiViewController: ForgotPasswordViewController, context: Context) {
        
    }
}

struct ForgotviewController_Previews: PreviewProvider {
    static var previews: some View {
        ForgotviewControllerRepresentable()
    }
}
