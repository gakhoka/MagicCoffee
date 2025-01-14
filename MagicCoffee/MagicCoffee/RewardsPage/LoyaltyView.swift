//
//  LoyaltyVie.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import SwiftUI

struct LoyaltyView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 150) {
                    Text("Loyalty card")
                    
                    Text("4/8")
                }
                .foregroundColor(.nardoGray)
                HStack(spacing: 15) {
                    ForEach(0..<8, id: \.self) { _ in
                        Image("coffeeImage")
                            .foregroundColor(.gray)
                    }
                }
                .roundedRect(height: 50, color: .white)
                .padding(.horizontal)

            }
        }
        .poppinsFont(size: 20)
        .roundedRect()
    }
}

#Preview {
    LoyaltyView()
}
