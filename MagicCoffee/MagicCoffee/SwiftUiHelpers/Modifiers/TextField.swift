//
//  TextField.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 31.01.25.
//

import SwiftUI


extension View {
    func cardTextField() -> some View {
        modifier(TextFieldModifier())
    }
}


struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .keyboardType(.numberPad)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .frame(maxWidth: .infinity)
    }
}
