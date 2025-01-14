//
//  RedeemPointsView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import SwiftUI

struct RedeemPointsView: View {
    var body: some View {
        ZStack {
            HStack(spacing: 70) {
                VStack(alignment: .leading, spacing: 25) {
                    Text("My points")
                        .font(.system(size: 16))
                    Text("2065")
                }
                .foregroundColor(.nardoGray)
                
               redeemButton
            }
            
            .padding()
            
            beansImage
        }
        .roundedRect()
    }
    
    private var redeemButton: some View {
        Button(action:  {
            //todo
        }) {
            Text("Redeem Drinks")
                .redeemButton()
        }
    }
    
    private var beansImage: some View {
        Image("beans")
            .frame(width: 50, height: 50)
            .foregroundColor(.white)
            .rotationEffect(.degrees(20))
            .offset(x: 150, y: 60)
    }
}

#Preview {
    RedeemPointsView()
}
