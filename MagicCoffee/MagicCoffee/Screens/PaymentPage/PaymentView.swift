//
//  PaymentView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 24.01.25.
//

import SwiftUI

struct PaymentView: View {
    
    @ObservedObject var viewModel: OrderViewModel
    @StateObject var cardViewModel = CreditCardViewmodel()
    @State private var selectedCardIndex: Int? = nil
    @State private var isCardTapped = false
    @State private var isPaymentMethodSelected = false
    @State private var noMethodsSelected = false
    @State private var shouldNavigate = false
    @State private var applePayMethod = false
    @Binding var path: NavigationPath

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
                    if applePayMethod == false {
                        Image(systemName:"apple.logo")
                        Text("Pay")
                    } else {
                        ZStack {
                            Circle()
                                .fill(.green)
                                .frame(width: 35, height: 35)
                            Image(systemName: "checkmark")
                                .foregroundStyle(.white)
                        }
                    }
                }
                .foregroundStyle(.white)
                .roundedRectangleStyle(color: .black)
                .frame(width: 300, height: 60)
                .padding(.horizontal)
                .animation(.easeIn(duration: 0.6), value: applePayMethod)
                .onTapGesture {
                    applePayMethod = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        viewModel.placeOrder()
                        shouldNavigate = true
                    }
                }
                
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
                        if isPaymentMethodSelected  {
                            viewModel.placeOrder()
                            shouldNavigate = true
                        } else {
                            noMethodsSelected.toggle()
                        }
                    } label: {
                        HStack {
                            Image("card")
                            Text("Pay Now")
                                .poppinsFont(size: 14)
                        }
                        .nextButtonAppearance()
                    }
                    .disabled(applePayMethod)
                    .frame(width: UIScreen.main.bounds.width / 2)
                }
            }
            .padding()
            .poppinsFont(size: 24)
        }
        .fullScreenCover(isPresented: $shouldNavigate, content: {
            FinalOrderDetailsView(cardViewModel: cardViewModel, viewModel: viewModel, path: $path)
                .navigationBarBackButtonHidden(true)
                .presentationDetents([.height(300)])
        })
        .onAppear(perform: cardViewModel.getGreditCard)
    }
}

#Preview {
    PaymentView(viewModel: OrderViewModel(), path: .constant(NavigationPath()))
}
