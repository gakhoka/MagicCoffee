//
//  CustomButton.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//


import SwiftUI

extension View {
    func capsuleButton() -> some View {
        modifier(CustomButton())
    }
}


struct CustomButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 50, maxHeight: 10)
            .padding()
            .background(Capsule().stroke(Color.gray.opacity(0.5), lineWidth: 1))
            .foregroundStyle(.black)
            
    }
}
