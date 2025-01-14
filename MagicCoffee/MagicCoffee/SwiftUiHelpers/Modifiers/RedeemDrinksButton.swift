//
//  RedeemDrinksButton.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import SwiftUI

extension View {
    func redeemButton() -> some View {
        modifier(CustomRedeemButton())
    }
}

struct CustomRedeemButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.nardoGray)
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(12)
    }
}
