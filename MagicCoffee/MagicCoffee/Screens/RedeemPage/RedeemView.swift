//
//  RedeemView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 16.01.25.
//

import SwiftUI

struct RedeemView: View {
    
    @ObservedObject var viewModel: RewardsViewModel
    @ObservedObject var orderViewmodel: OrderViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            Text(viewModel.notEnoughPoints ? "Not enough points" : "")
                .foregroundStyle(.red)
                .opacity(viewModel.notEnoughPoints ? 1 : 0)
                .animation(.easeOut(duration: 1), value: viewModel.notEnoughPoints)
            Text(viewModel.isCoffeeRedeemed ? "Coffee is redeemed ! Enjoy" : "")
                .opacity(viewModel.isCoffeeRedeemed ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: viewModel.isCoffeeRedeemed)
                
                List {
                    ForEach(viewModel.freeCoffees) { coffee in
                        HStack {
                            AsyncCoffeeView(image: coffee.image)
                        Spacer()
                        VStack(alignment: .leading, spacing: 10) {
                            Text(coffee.name)
                            Text("Valid until \(coffee.validityDate)")
                                .font(.system(size: 14))
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                        Button("\(coffee.redeemPointsAmount) pts") {
                            viewModel.redeemCoffee(coffee: coffee)
                        }
                        .roundedRectangleStyle(cornerRadius: 50)
                        .frame(width: 90, height: 35)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            withAnimation {
                                viewModel.redeemCoffee(coffee: coffee)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    viewModel.isCoffeeRedeemed = false
                                    viewModel.notEnoughPoints = false
                                }
                            }
                        }
                    }
                    .padding([.top, .bottom])
                }
                .listRowInsets(.none)
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            
        }
        .onAppear {
            viewModel.fetchRedeemableCoffees()
            viewModel.updateUserScore()
        }
        .padding()
        .navigationTitle("Redeem")
        .poppinsFont(size: 16)
        .customBackButton {
            dismiss()
        }
    }
}

#Preview {
    RedeemView(viewModel: RewardsViewModel(orderViewModel: OrderViewModel()), orderViewmodel: OrderViewModel(), path: .constant(NavigationPath()))
}
