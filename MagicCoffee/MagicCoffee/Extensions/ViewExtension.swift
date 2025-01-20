//
//  ViewExtension.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 20.01.25.
//


import SwiftUI

extension View {
    func customBackButton(dismissAction: @escaping () -> Void) -> some View{
        self
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                dismissAction()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.black)
            })
    }
}
