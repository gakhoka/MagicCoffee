//
//  LabelExtension.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 12.01.25.
//

import UIKit

extension UILabel {
    func createLabel(text: String, textColor: UIColor = .black, font: CGFloat = 24) {
        self.text = text
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: font)
        self.textColor = textColor
    }
}
