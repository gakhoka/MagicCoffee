//
//  VerificationViewController.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import SwiftUI
import UIKit

class VerificationViewController: UIViewController {
    
    
    private lazy var verificationLabel: UILabel = {
        let label = UILabel()
        label.create(text: "Verification")
        return label
    }()
    
    private lazy var headerText: UILabel = {
        let label = UILabel()
        label.create(text: "Enter the code we sent you", textColor: .systemGray2, font: 14)
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
        setupDigitEntryView()
    }
    
    private func setupDigitEntryView() {
        let digitEntryView = FourDigitEntryView()
             digitEntryView.onCodeComplete = { code in
                 //TODO: code comletion
             }
             
             view.addSubview(digitEntryView)
             digitEntryView.translatesAutoresizingMaskIntoConstraints = false
             NSLayoutConstraint.activate([
                 digitEntryView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                 digitEntryView.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 100),
                 digitEntryView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                 digitEntryView.heightAnchor.constraint(equalToConstant: 100)
             ])

       }
    
    private func placeViews() {
        view.addSubview(verificationLabel)
        view.addSubview(headerText)
        
    }
    
    private func leftBarButtonConfig() {
        configureLeftBarButton(icon: "arrow.left", action: { [weak self] in
            self?.backButtonTapped()
        })
    }
    
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verificationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            verificationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            headerText.topAnchor.constraint(equalTo: verificationLabel.bottomAnchor, constant: 20),
            headerText.leftAnchor.constraint(equalTo: verificationLabel.leftAnchor),
        ])
    }

}

struct VerificationviewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = VerificationViewController
    
    
    func makeUIViewController(context: Context) -> VerificationViewController {
        VerificationViewController()
    }
    
    func updateUIViewController(_ uiViewController: VerificationViewController, context: Context) {
        
    }
}

struct VerificationviewController_Previews: PreviewProvider {
    static var previews: some View {
        VerificationviewControllerRepresentable()
    }
}
