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
    @Binding var path: NavigationPath
    @State var prepareTime = ""

    var body: some View {
        VStack(alignment: .center, spacing: 40) {
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
                .padding(.horizontal, 20)

            
            Text("Your order will be ready today at \(prepareTime)")
                .padding(.horizontal, 20)
           
            
            Text("Submit your personal QR code at a coffee shop to receive an order")
                .foregroundColor(.gray)
                .padding(.horizontal, 20)

            Spacer()
        }
        .onAppear {
            prepareTime = viewModel.prepareTime().formattedDate()
        }
        .multilineTextAlignment(.center)
        .padding()
        .poppinsFont(size: 16)
    }
}

#Preview {
    FinalOrderDetailsView(cardViewModel: CreditCardViewmodel(), viewModel: OrderViewModel(), path: .constant(NavigationPath()))
}
