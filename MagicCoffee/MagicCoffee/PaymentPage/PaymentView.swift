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
    @StateObject var cardViewModel = CreditCardViewmodel()
    @State private var selectedCardIndex: Int? = nil
    @State private var isPaymentMethodSelected = false
    @State private var noMethodsSelected = false

    
    let username = UserDefaults.standard.string(forKey: "username")
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Text(noMethodsSelected ? "Please select payment method": "")
                        .foregroundStyle(.red)
                        .font(.system(size: 14))
                
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
                    
                    NavigationLink(destination: CardDetailsView(cardsViewModel: cardViewModel).navigationBarBackButtonHidden(true)) {
                        Image("addcard")
                            .foregroundColor(.black)
                    }
                }
                .padding()
                .poppinsFont(size: 14)
                
                List {
                    ForEach(cardViewModel.userCards.indices, id: \.self) { index in
                        let card = cardViewModel.userCards[index]
                        HStack {
                            ZStack {
                                Circle()
                                    .stroke(lineWidth: 1)
                                    .fill(.black)
                                    .frame(width: 18, height: 18)
                                    .padding()
                                Circle()
                                    .fill(index == selectedCardIndex ? .black : .clear)
                                    .frame(width: 10, height: 10)
                                    .padding()
                            }
                            VStack(alignment: .leading) {
                                Text("Credit Card")
                                    .poppinsFont(size: 18)
                                Text(card.cardNumber)
                                    .poppinsFont(size: 14)
                                    .foregroundStyle(.gray)
                            }

                            Spacer()
                            HStack {
                                Image("visa")
                                Image("mastercard")
                            }
                        }
                        .contextMenu {
                            Button("Delete") {
                                cardViewModel.removeCard(at: index)
                            }
                            .tint(.red)
                        }
                        .roundedRectangleStyle(color: .lightGrayBackground)
                        .frame(height: 100)
                        .onTapGesture {
                            if selectedCardIndex == index {
                                selectedCardIndex = nil
                            } else {
                                selectedCardIndex = index
                                isPaymentMethodSelected = true
                            }
                        }
                    }
                  
                    .listRowInsets(.none)
                    .listRowSeparator(.hidden)
                }
                .scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)

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
                        .onTapGesture {
                            if isPaymentMethodSelected {
                                viewModel.placeOrder()
                            } else {
                                noMethodsSelected.toggle()
                            }
                        }
                    }
                    .poppinsFont(size: 14)
                }
            }
            .padding()
            .poppinsFont(size: 24)
        }
        
        .onAppear(perform: cardViewModel.getGreditCard)
    }
}

#Preview {
    PaymentView(viewModel: OrderViewModel())
}
