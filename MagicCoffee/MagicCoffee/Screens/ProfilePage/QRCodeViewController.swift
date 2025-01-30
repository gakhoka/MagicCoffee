//
//  QRCodeViewController.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 29.01.25.
//


import UIKit

class QRCodeViewController: UIViewController {
    
    private lazy var qrImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        button.addAction(UIAction(handler: { [weak self] action in
            self?.navigateBack()
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var scanLabel: UILabel = {
        let label = UILabel()
        label.create(text: "Scan your QR code", font: 18)
        return label
    }()

    init(qrImage: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        qrImageView.image = qrImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        placeViews()
        setupConstraints()
    }
    
    private func placeViews() {
        view.addSubview(qrImageView)
        view.addSubview(backButton)
        view.addSubview(scanLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            qrImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qrImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            qrImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            qrImageView.heightAnchor.constraint(equalTo: qrImageView.widthAnchor),
            
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            scanLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scanLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
