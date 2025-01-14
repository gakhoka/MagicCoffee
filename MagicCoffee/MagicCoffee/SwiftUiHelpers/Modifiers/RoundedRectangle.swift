//
//  RoundedRectangle.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import SwiftUI

extension View {
    func roundedRect(width: CGFloat = .infinity ,height: CGFloat = 150, cornerRadius: CGFloat = 10, color: Color = .navyGreen) -> some View {
        modifier(RoundedRect(height: height, cornerRadius: cornerRadius, color: color, width: width))
    }
}

struct RoundedRect: ViewModifier {
    let height: CGFloat
    let cornerRadius: CGFloat
    let color: Color
    let width: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .frame(width: width, height: height)
                .padding(.horizontal)
            content
        }
    }
}
