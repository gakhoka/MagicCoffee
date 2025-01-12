//
//  StackViewExtension.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 12.01.25.
//

import Foundation
import UIKit

extension UIStackView {
    func addMultipleViews(_ view: UIView...) {
        for view in view {
            self.addArrangedSubview(view)
        }
    }
    
    func configure() {
        self.axis = .vertical
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .equalSpacing
        self.spacing = 30
    }
}

