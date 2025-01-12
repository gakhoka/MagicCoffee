//
//  LabelExtension.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 12.01.25.
//

import UIKit

extension UILabel {
    func create(text: String, textColor: UIColor = .black, font: CGFloat = 24, customFontName: String? = nil) {
        self.text = text
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: font)
        self.textColor = textColor
        
        if let customFontName = customFontName, let customFont = UIFont(name: customFontName, size: font) {
            self.font = customFont
        } else if let poppinsFont = UIFont(name: "Poppins", size: font) {
            self.font = poppinsFont
        } else {
            self.font = UIFont.systemFont(ofSize: font)
        }
    }
}
