//
//  Modifiers.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import Foundation
import SwiftUI

extension View {
    func roundedRectangleStyle(cornerRadius: CGFloat = 20, color: Color = .navyGreen) -> some View {
        modifier(RoundedRectangleStyle(cornerRadius: cornerRadius, color: color))
    }
    
    func poppinsFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        modifier(PoppinsFontModifier(size: size, weight: weight))
    }
}

struct RoundedRectangleStyle: ViewModifier {
    let cornerRadius: CGFloat
    let color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width)
                .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height)
            content
        }
    }
}


struct PoppinsFontModifier: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight = .regular
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Poppins", size: size).weight(weight))
    }
}

