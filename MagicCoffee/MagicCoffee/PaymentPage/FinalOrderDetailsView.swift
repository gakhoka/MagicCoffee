//
//  FinalOrderDetailsView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 25.01.25.
//

import SwiftUI
import Combine

struct FinalOrderDetailsView: View {
    
    @ObservedObject var cardViewModel: CreditCardViewmodel
    @ObservedObject var viewModel: OrderViewModel
    @Binding  var path: NavigationPath

    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Spacer()
                Button {
                    path = NavigationPath()
                } label: {
                    Image("Home")
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Image("takeaway")
            
            Text("Ordered !")
                .font(.largeTitle)
                .font(.system(size: 22))
            
            Text("\(String(describing: cardViewModel.username)) your order has successfully been placed")
                .foregroundColor(.gray)
            
            Text("Your order will be ready today at \(viewModel.orderDate.formattedDate())")
           
            
            Text("Submit your personal QR code at a coffee shop to receive an order")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .poppinsFont(size: 16)
    }
}

#Preview {
    FinalOrderDetailsView(cardViewModel: CreditCardViewmodel(), viewModel: OrderViewModel(), path: .constant(NavigationPath()))
}
