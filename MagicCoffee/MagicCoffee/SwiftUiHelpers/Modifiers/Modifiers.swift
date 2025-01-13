//
//  Modifiers.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import Foundation
import SwiftUI

extension View {
    func roundedRectangleStyle(width: CGFloat = 500, height: CGFloat = 500, cornerRadius: CGFloat = 20, color: Color = .navyGreen) -> some View {
        modifier(RoundedRectangleStyle(width: width, height: height, cornerRadius: cornerRadius, color: color))
    }
    
    func poppinsFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        modifier(PoppinsFontModifier(size: size, weight: weight))
    }
}

struct RoundedRectangleStyle: ViewModifier {
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .frame(width: width, height: height)
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

