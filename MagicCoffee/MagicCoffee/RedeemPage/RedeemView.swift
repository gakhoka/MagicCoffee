//
//  RedeemView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 16.01.25.
//

import SwiftUI

struct RedeemView: View {
    
    @ObservedObject var viewModel = RedeemViewModel()
    
    var body: some View {
        VStack() {
            List {
                ForEach(viewModel.coffees) { coffee in
                    HStack {
                        Image(coffee.image)
                            .padding(.leading, -15)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(coffee.name)
                            Text("Valid until \(coffee.validityDate)")
                                .font(.system(size: 14))
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        Button("\(coffee.redeemPointsAmount)") {
                          //TODO: action
                        }
                        .roundedRectangleStyle(width: 75, height: 40, cornerRadius: 50)
                        .foregroundStyle(.white)
                    }
                    .padding([.top, .bottom])
                }
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)

        }
        .poppinsFont(size: 16)
    }
}

#Preview {
    RedeemView()
}
