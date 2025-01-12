//
//  ViewControllerExtension.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 12.01.25.
//

import UIKit

extension UIViewController {
    
    func configureLeftBarButton(icon: String, action: @escaping () -> Void) {
        let leftBarButton = UIButton(type: .system)
        leftBarButton.setImage(UIImage(systemName: icon), for: .normal)
        leftBarButton.tintColor = .black
        leftBarButton.translatesAutoresizingMaskIntoConstraints = false
        
        leftBarButton.addAction(UIAction { _ in
            action()
        }, for: .touchUpInside)
        
        view.addSubview(leftBarButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
    }
}
