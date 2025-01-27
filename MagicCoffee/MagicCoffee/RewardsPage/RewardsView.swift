//
//  RewardsView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import SwiftUI

struct RewardsView: View {
    
    @ObservedObject var orderViewModel: OrderViewModel
    @StateObject private var viewModel: RewardsViewModel
        
    init(orderViewModel: OrderViewModel) {
        self.orderViewModel = orderViewModel
        _viewModel = StateObject(wrappedValue: RewardsViewModel(orderViewModel: orderViewModel))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Rewards")
                
                LoyaltyView(viewModel: viewModel)
                
                RedeemPointsView(viewModel: viewModel, orderViewModel: orderViewModel)
                HStack {
                    Text("History Rewards")
                        .font(.system(size: 20))
                        .padding(.horizontal, 20)
                    Spacer()
                }
                
                List {
                    ForEach(viewModel.coffeeHistory) { coffee in
                        HStack {
                            VStack(alignment: .leading, spacing: 20) {
                                Text(coffee.name)
                                Text(coffee.orderDate.formattedDate())
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 15))
                            }
                            Spacer()
                            Text("+ \(coffee.score)")
                        }
                        .poppinsFont(size: 18)
                    }
                    .listRowSeparator(.visible)
                }
                .poppinsFont(size: 24)
                .onAppear(perform: viewModel.fetchUserOrders)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    RewardsView(orderViewModel: OrderViewModel())
}
