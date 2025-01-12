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
}
