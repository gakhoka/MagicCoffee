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
    @State private var path = NavigationPath()
    
    init(orderViewModel: OrderViewModel) {
        self.orderViewModel = orderViewModel
        _viewModel = StateObject(wrappedValue: RewardsViewModel(orderViewModel: orderViewModel))
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Text("Rewards")
                
                LoyaltyView(viewModel: viewModel)
                
                RedeemPointsView(viewModel: viewModel, orderViewModel: orderViewModel, path: $path)
                HStack {
                    Text("History Rewards")
                        .font(.system(size: 20))
                        .padding(.horizontal, 20)
                    Spacer()
                }
                .padding(.top)
                
                if !viewModel.coffeeHistory.isEmpty {
                    List {
                        ForEach(viewModel.coffeeHistory) { order in
                            VStack(alignment: .leading) {
                                Text(order.orderDate.formattedDate())
                                    .poppinsFont(size: 18)
                                    .foregroundColor(.gray)
                                    .padding([.top, .bottom])
                                
                                ForEach(order.coffee) { coffee in
                                    HStack {
                                        Text(coffee.name)
                                            .poppinsFont(size: 16)

                                        Spacer()
                                        Text("+ \(coffee.score) pts")
                                            .poppinsFont(size: 17)

                                    }
                                    .padding(.bottom, 5)
                                }
                            }
                        }
                        .listRowSeparator(.visible)
                    }
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
                } else {
                    Spacer()
                    VStack(spacing: 20) {
                        Spacer()
                        Image("noreward")
                            .foregroundColor(.navyGreen)
                        Text("No rewards yet")
                            .poppinsFont(size: 16)
                        Spacer()
                        Spacer()
                    }
                }
            }
            .onAppear(perform: viewModel.fetchUserOrders)
        }
    }
}

#Preview {
    RewardsView(orderViewModel: OrderViewModel())
}
