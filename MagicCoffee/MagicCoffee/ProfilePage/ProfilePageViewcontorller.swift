//
//  ProfilePageViewcontorller.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//


import SwiftUI
import UIKit

class ProfilePageViewController: UIViewController {
    
 
    private let viewModel = ProfileViewModel()
    private let qrcodeGenerator = QRcodeGenerator()
    private let qrImage = UIImageView()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logout"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] action in
            self?.signOutButtonTapped()
        }), for: .touchUpInside)
        return button
    }()
    
    private let mainstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var logOutLabel: UILabel = {
        let label = UILabel()
        label.create(text: "Log out", textColor: .systemGray2, font: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        configureViewModel()
    }
    
    private func setupUI() {
        placeViews()
        setupConstraints()
        qrCodeSetup()
    }
    
    private func placeViews() {
        view.addSubview(signOutButton)
        view.addSubview(qrImage)
        view.addSubview(mainstackView)
        view.addSubview(logOutLabel)
    }
    
    private func configureViewModel() {
        viewModel.updateHandler = { [weak self] in
            self?.setupProfileItems()
        }
    }
    
    private func qrCodeSetup() {
        let credentials = qrcodeGenerator.generateQRCode(from: "\(viewModel.username)")
        
        qrImage.translatesAutoresizingMaskIntoConstraints = false
        qrImage.image = credentials

    }
    
    private func signOutButtonTapped() {
        viewModel.signOut { [weak self] in

            guard self == self else { return }
            let loginPageViewController = WelcomePageViewController()
            let navigationController = UINavigationController(rootViewController: loginPageViewController)
            
            UIView.transition(
                with: (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window ?? UIWindow(),
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: {
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController = navigationController
                },
                completion: nil
            )
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.makeKeyAndVisible()
        }
    }

    private func updateqr() {
        viewModel.updateHandler = { [weak self] in
            guard let username = self?.viewModel.username else { return }
            print(username)
            let qrCodeImage = self?.qrcodeGenerator.generateQRCode(from: username)
            DispatchQueue.main.async {
                self?.qrImage.image = qrCodeImage
            }
        }
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
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainstackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            mainstackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            mainstackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            qrImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            qrImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signOutButton.topAnchor.constraint(equalTo: mainstackView.bottomAnchor, constant: 30),
            signOutButton.leftAnchor.constraint(equalTo: mainstackView.leftAnchor, constant: 45),
            
            logOutLabel.leftAnchor.constraint(equalTo: signOutButton.rightAnchor, constant: 20),
            logOutLabel.centerYAnchor.constraint(equalTo: signOutButton.centerYAnchor)
        ])
    }
    
    private func setupProfileItems() {
        mainstackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let items = [
            ("Profile", "Name", viewModel.username),
            ("Message", "Email", viewModel.email),
            ("Lock", "Password", "*********")
        ]
        
        items.forEach { icon, title, value in
            let itemView = self.createProfileItemView(icon: icon, title: title, value: value)
            self.mainstackView.addArrangedSubview(itemView)
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
                viewModel.updateProfile(username: valueTextField.text ?? "", email: viewModel.email) { _ in
                    self.updateqr()
                }
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
