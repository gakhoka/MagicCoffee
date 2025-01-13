//
//  nextButton.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.01.25.
//

import SwiftUI


extension View {
    func nextButtonAppearance() -> some View {
        modifier(CustomNextButton())
    }
}

struct CustomNextButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.navyGreen)
            .cornerRadius(20)
            .padding()
    }
}
