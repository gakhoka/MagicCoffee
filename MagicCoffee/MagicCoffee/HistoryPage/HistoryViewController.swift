//
//  HistoryViewController.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 15.01.25.
//


import SwiftUI
import UIKit

class HistoryViewController: UIViewController {

    
    private var underlineLeadingConstraint: NSLayoutConstraint!

    private lazy var ongoingButton: UIButton = {
        let button = UIButton(type: .system)
        button.create(title: "On going")
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.addAction(UIAction(handler: { [weak self] action in
            self?.didTapOngoing()
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var  historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.create(title: "History")
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.addAction(UIAction(handler: { [weak self] action in
            self?.didTapHistory()
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var grayUnderLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "My Order"
        
        setupUI()
    }
    
    private func setupUI() {
        setupButtons()
    }
    
    private func setupButtons() {
        
        let buttonStack = UIStackView(arrangedSubviews: [ongoingButton, historyButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        view.addSubview(underlineView)
        view.addSubview(grayUnderLineView)
        
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            buttonStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
            buttonStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            buttonStack.heightAnchor.constraint(equalToConstant: 50),
            
            underlineView.heightAnchor.constraint(equalToConstant: 2),
            underlineView.bottomAnchor.constraint(equalTo: buttonStack.bottomAnchor),
            underlineView.widthAnchor.constraint(equalTo: ongoingButton.widthAnchor),
           
            
            grayUnderLineView.bottomAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 1),
            grayUnderLineView.heightAnchor.constraint(equalToConstant: 1),
            grayUnderLineView.leftAnchor.constraint(equalTo: view.leftAnchor),
            grayUnderLineView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        underlineLeadingConstraint = underlineView.leadingAnchor.constraint(equalTo: ongoingButton.leadingAnchor)
        underlineLeadingConstraint.isActive = true
    }
   
    
     private func didTapOngoing() {
        updateTabSelection(selectedButton: ongoingButton, unselectedButton: historyButton)
        
    }
    
     private func didTapHistory() {
        updateTabSelection(selectedButton: historyButton, unselectedButton: ongoingButton)
    }
    
    private func updateTabSelection(selectedButton: UIButton, unselectedButton: UIButton) {
        selectedButton.setTitleColor(.black, for: .normal)
        unselectedButton.setTitleColor(.gray, for: .normal)
        
        UIView.animate(withDuration: 0.3) {
            self.underlineLeadingConstraint.constant = selectedButton.frame.origin.x
            self.view.layoutIfNeeded()
        }
    }
}


struct HistoryviewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = HistoryViewController
    
    
    func makeUIViewController(context: Context) -> HistoryViewController {
        HistoryViewController()
    }
    
    func updateUIViewController(_ uiViewController: HistoryViewController, context: Context) {
        
    }
}

struct HistoryviewController_Previews: PreviewProvider {
    static var previews: some View {
        HistoryviewControllerRepresentable()
    }
}
