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
    private let profileItem = ProfileItemViewHelper()
    private let qrImage = UIImageView()
    
    private lazy var signoutView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGrayBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.create(image: "arrow.left", tintColor: .black)
        button.addAction(UIAction(handler: { [weak self] action in
            self?.navigateBack()
        }), for: .touchUpInside)
        return button
    }()
    
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
    
    private lazy var mainstackView: UIStackView = {
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
        label.create(text: "Log out", textColor: .black, font: 14)
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
        view.addSubview(qrImage)
        view.addSubview(mainstackView)
        view.addSubview(backButton)
        view.addSubview(signoutView)
        signoutView.addSubview(signOutButton)
        signoutView.addSubview(logOutLabel)
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
        qrImage.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(qrImageTapped))
        qrImage.addGestureRecognizer(tapGesture)
    }

    @objc private func qrImageTapped() {
        let qrVC = QRCodeViewController(qrImage: qrImage.image)
        navigationController?.pushViewController(qrVC, animated: true)
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
            
            let qrCodeImage = self?.qrcodeGenerator.generateQRCode(from: username)
            DispatchQueue.main.async { [weak self] in
                self?.qrImage.image = qrCodeImage
            }
        }
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            mainstackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            mainstackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            mainstackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            signoutView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            signoutView.leftAnchor.constraint(equalTo: mainstackView.leftAnchor, constant: 20),
            
            signoutView.rightAnchor.constraint(equalTo: mainstackView.rightAnchor, constant: -20),
            signoutView.heightAnchor.constraint(equalToConstant: 80),
            
            signOutButton.leftAnchor.constraint(equalTo: signoutView.leftAnchor, constant: 20),
            signOutButton.centerYAnchor.constraint(equalTo: signoutView.centerYAnchor),
            
            logOutLabel.leftAnchor.constraint(equalTo: signOutButton.rightAnchor, constant: 5),
            logOutLabel.centerYAnchor.constraint(equalTo: signOutButton.centerYAnchor),
            
            qrImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            qrImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
            qrImage.heightAnchor.constraint(equalToConstant: 30),
            qrImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupProfileItems() {
        mainstackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let items = [
            ("person", "Name", viewModel.username),
            ("envelope", "Email", viewModel.email),
            ("lock", "Password", "*********")
        ]
        
        items.forEach { [weak self] icon, title, value in
            let itemView = self?.profileItem.createProfileItemView(icon: icon, title: title, value: value, toggleEdit: { button in
                   self?.toggleEdit(button)
               })
            self?.mainstackView.addArrangedSubview(itemView ?? UIView())
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
