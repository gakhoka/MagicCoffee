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
    @Environment(\.dismiss) var dismiss
    @State private var selectedCardIndex: Int? = nil
    @State private var isCardTapped = false
    @State private var isPaymentMethodSelected = false
    @State private var noMethodsSelected = false
    @State private var shouldNavigate = false
    @State private var applePayMethod = false
    @State private var selectOnePaymentAlert = false
    @State private var isAddCardTapped = false
    @Binding var path: NavigationPath
    
    let username = UserDefaults.standard.string(forKey: "username")
    
    var body: some View {
        NavigationView {
            VStack {
                paymentAlert
                addCard
                orderList
                applePay
                bottomView
            }
            .padding()
            .poppinsFont(size: 24)
        }
        .fullScreenCover(isPresented: $shouldNavigate, content: {
            FinalOrderDetailsView(cardViewModel: cardViewModel, viewModel: viewModel, path: $path)
                .navigationBarBackButtonHidden(true)
                .presentationDetents([.height(300)])
        })
        .customBackButton {
            dismiss()
        }
        .sheet(isPresented: $isAddCardTapped, content: {
            CardDetailsView(cardsViewModel: cardViewModel)
                .presentationDetents([.height(500)])
        })
        .navigationTitle("Order Payment")
        .onAppear(perform: cardViewModel.getGreditCard)
        Spacer()
    }
    
    private var timePicker: some View {
        HStack {
            Image("calendar")
                .padding(.leading)
                
            DatePicker("", selection: $viewModel.pickDate, in: Date()...,  displayedComponents: [.hourAndMinute , .date])
                .opacity(viewModel.isDatePickerOn ? 1 : 0)
                .animation(.easeIn(duration: 0.5), value: viewModel.isDatePickerOn)
                .padding(.leading)
            
            Toggle("", isOn: $viewModel.isDatePickerOn)
        }
        .padding()
    }
    
    private var addCard: some View {
        VStack(alignment: .leading, spacing: 40) {
            HStack {
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(cardViewModel.username)
                        .poppinsFont(size: 20)
                    Text("Magic coffee store")
                        .poppinsFont(size: 16)
                        .foregroundStyle(.gray)
                }
                Spacer()
                Button {
                    isAddCardTapped.toggle()
                } label: {
                    Image("addcard")
                        .foregroundColor(.navyGreen)
                        
                }
            }
            .padding(.horizontal)
            timePicker
            Text("Credit and Debit cards")
                .poppinsFont(size: 20)
                .padding(.horizontal)
        }
    }
    
    private var bottomView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Total amount")
                    .foregroundStyle(.gray)
                    .font(.system(size: 16))
                HStack {
                    Text("$")
                    Text(String(format: "%.2f", viewModel.total))
                        .font(.system(size: 24))
                }
            }
            .padding(.horizontal)
            .poppinsFont(size: 14)
            
            Spacer()
            VStack {
                Button {
                    if isPaymentMethodSelected  {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            viewModel.placeOrder()
                            shouldNavigate = true
                        }
                    } else {
                        noMethodsSelected = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            noMethodsSelected = false
                        }
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
        .padding(.bottom, -25)
    }
    
    private var applePay: some View {
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
            if isPaymentMethodSelected == false {
                applePayMethod = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    noMethodsSelected = false
                    viewModel.placeOrder()
                    shouldNavigate = true
                }
            } else {
                selectOnePaymentAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    selectOnePaymentAlert = false
                }
            }
        }
        .padding(.bottom)
    }
    
    private var orderList: some View {
        List {
            if cardViewModel.userCards.isEmpty {
                VStack {
                    Image(systemName: "creditcard.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(
                            .linearGradient(colors: [.creamColor, .coffeeBeanColor, .navyGreen, .brownColor], startPoint: .top, endPoint: .bottomTrailing))
                    
                    Text("No cards added")
                        .poppinsFont(size: 18)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, minHeight: 200)
            } else {
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
                            Text(card.cardNumber.hiddeMiddleNumbers())
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
                    .onTapGesture {
                        if selectedCardIndex == index {
                            selectedCardIndex = nil
                            isPaymentMethodSelected = false
                        } else {
                            selectedCardIndex = index
                            isPaymentMethodSelected = true
                        }
                    }
                }
                .frame(height: 100)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowInsets(.none)
                .listRowSeparator(.hidden)
                .padding(.vertical)
            }
        }
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .padding(.bottom)
    }
    
    private var paymentAlert: some View {
        Text(selectOnePaymentAlert ? "Please select one payment" : (noMethodsSelected ? "Please select payment method" : ""))
            .foregroundStyle(.red)
            .poppinsFont(size: 14)
            .animation(.easeOut(duration: 0.5), value: selectOnePaymentAlert)
            .animation(.easeInOut(duration: 0.5), value: noMethodsSelected)
    }
}

#Preview {
    PaymentView(viewModel: OrderViewModel(), path: .constant(NavigationPath()))
}
