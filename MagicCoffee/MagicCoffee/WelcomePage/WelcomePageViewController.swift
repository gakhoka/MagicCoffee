//
//  ViewController.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 12.01.25.
//

import UIKit
import SwiftUI

class WelcomePageViewController: UIViewController {
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .navyGreen
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .white
        button.addAction(UIAction(handler: { [weak self] action in
            self?.navigateToLogInPage()
        }), for: .touchUpInside)
        button.layer.cornerRadius = 25
        return button
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Magic coffee on order."
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.createLabel(text: "Feel yourself like a barista !", font: 40)
        return label
    }()
    
    private lazy var appName: UILabel = {
        let label = UILabel()
        label.createLabel(text: "Magic Coffee", textColor: .white)
        label.font = UIFont(name: "ReenieBeanie", size: 50)
        return label
    }()
    
    private lazy var logoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .navyGreen
        return view
    }()

    private lazy var appImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CoffeeLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func navigateToLogInPage() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    private func setupUI() {
        placeViews()
        setupConstraints()
    }
    
    private func placeViews() {
        view.addSubview(logoView)
        view.addSubview(appImage)
        view.addSubview(appName)
        view.addSubview(headerLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            logoView.leftAnchor.constraint(equalTo: view.leftAnchor),
            logoView.rightAnchor.constraint(equalTo: view.rightAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 300),
            
            appImage.centerYAnchor.constraint(equalTo: logoView.centerYAnchor, constant: -40),
            appImage.centerXAnchor.constraint(equalTo: logoView.centerXAnchor),
            appImage.heightAnchor.constraint(equalToConstant: 200),
            appImage.widthAnchor.constraint(equalToConstant: 150),
            
            appName.topAnchor.constraint(equalTo: appImage.bottomAnchor, constant: 0),
            appName.centerXAnchor.constraint(equalTo: logoView.centerXAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 50),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            subtitleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 50)
            
        ])
    }
   
}



struct viewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = WelcomePageViewController
    
    
    func makeUIViewController(context: Context) -> WelcomePageViewController {
        WelcomePageViewController()
    }
    
    func updateUIViewController(_ uiViewController: WelcomePageViewController, context: Context) {
        
    }
}

struct viewController_Previews: PreviewProvider {
    static var previews: some View {
        viewControllerRepresentable()
    }
}

