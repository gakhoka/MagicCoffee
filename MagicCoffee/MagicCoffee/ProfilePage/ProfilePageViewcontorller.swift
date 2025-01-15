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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        leftBarButtonConfig()
        setupStackView()
        setupProfileItems()
    }
    
    private func leftBarButtonConfig() {
        configureLeftBarButton(icon: "arrow.left", action: { [weak self] in
            self?.backButtonTapped()
        })
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
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 16)
        
        let editButton = UIButton()
        editButton.setImage(UIImage(named: "Edit"), for: .normal)
        editButton.tintColor = .systemGray
        
        containerView.addSubview(iconImage)
        containerView.addSubview(labelsStack)
        containerView.addSubview(editButton)
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(valueLabel)
        
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
        let items = [
            ("Profile", "Name", "Alex"),
            ("Phone", "Phone number", "+375 33 664-57-36"),
            ("Message", "Email", "adosmenesk@pm.me"),
        ]
        
        items.forEach { icon, title, value in
            let itemView = createProfileItemView(icon: icon, title: title, value: value)
            stackView.addArrangedSubview(itemView)
        }
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
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
