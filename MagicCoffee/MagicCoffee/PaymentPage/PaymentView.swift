//
//  PaymentView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 24.01.25.
//

import SwiftUI

struct PaymentView: View {
    
    @ObservedObject var viewModel: OrderViewModel
    @State private var isCardTapped = false
    
    let username = UserDefaults.standard.string(forKey: "username")

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            HStack {
                Text("Order payment")
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack(spacing: 10) {
                Image("paymentCart")
                    .frame(width: 40, height: 40)
                    .background(Color.lightGrayBackground)
                VStack(alignment: .leading) {
                    Text(username ?? "")
                        .poppinsFont(size: 16)
                    Text("Magic coffee store")
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal)
                Spacer()
            }
            .padding()
            .poppinsFont(size: 14)
            
            HStack {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 1)
                        .fill(.black)
                        .frame(width: 18, height: 18)
                        .padding()
                    Circle()
                        .fill(isCardTapped ? .black : .clear)
                        .frame(width: 10, height: 10)
                        .padding()
                        
                }
                VStack(alignment: .leading) {
                    Text("Credit Card")
                        .poppinsFont(size: 18)
                    Text("299434xxx013232")
                        .poppinsFont(size: 14)
                        .foregroundStyle(.gray)
                }
                
                
                Spacer()
                HStack {
                    Image("visa")
                    Image("mastercard")
                }
            }
            .roundedRectangleStyle(color: .lightGrayBackground)
            .frame(height: 100)
            .padding(.horizontal)
            .onTapGesture {
                isCardTapped.toggle()
            }
            
            HStack {
                Image(systemName:"apple.logo")
                Text("Pay")
            }
            .foregroundStyle(.white)
            .roundedRectangleStyle(color: .black)
            .frame(height: 70)
            .padding(.horizontal)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Total amount")
                        .foregroundStyle(.gray)
                    HStack {
                        Text("$")
                        Text(String(format: "%.2f", viewModel.total))
                    }
                    .poppinsFont(size: 20)

                }
                .padding(.horizontal)
                .poppinsFont(size: 14)

                Spacer()
                
                Button {
                    
                } label: {
                    HStack {
                        Image("card")
                        Text("Pay Now")
                    }
                    .nextButtonAppearance()
                    .frame(width: UIScreen.main.bounds.width / 2)
                }
                .poppinsFont(size: 14)
            }
        }
        .padding()
        .poppinsFont(size: 24)
    }
}

#Preview {
    PaymentView(viewModel: OrderViewModel())
}
