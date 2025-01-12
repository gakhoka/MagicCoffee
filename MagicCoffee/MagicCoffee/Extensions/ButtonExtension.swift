//
//  ButtonExtension.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 12.01.25.
//

import Foundation
import UIKit

extension UIButton {
    func create(title: String? = nil, image: String? = nil, cornerRadious: CGFloat? = nil, backgroundColor: UIColor = .white, tintColor: UIColor = .white) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(.black, for: .normal)
        self.tintColor = tintColor
        self.setImage(UIImage(systemName: image ?? ""), for: .normal)
        self.layer.cornerRadius = cornerRadious ?? 25
    }
}
