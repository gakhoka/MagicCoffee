//
//  RedeemPointsView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import SwiftUI

struct RedeemPointsView: View {
    
    @ObservedObject var viewModel: RewardsViewModel
    @ObservedObject var orderViewModel: OrderViewModel
    @Binding var path: NavigationPath
    
    var body: some View {
        ZStack {
            HStack(spacing: 70) {
                VStack(spacing: 25) {
                    Text("My points")
                    Text("\(viewModel.userPoints)")
                       
                }
                .poppinsFont(size: 20)
                .foregroundColor(.nardoGray)
                
               redeemButton
            }
            
            .padding()
            
            beansImage
        }
        .roundedRect()
    }
    
    private var redeemButton: some View {
        NavigationLink(destination: RedeemView(viewModel: viewModel, orderViewmodel: orderViewModel, path: $path).navigationBarBackButtonHidden(true)) {
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
    RedeemPointsView(viewModel: RewardsViewModel(orderViewModel: OrderViewModel()), orderViewModel: OrderViewModel(), path: .constant(NavigationPath()))
}
