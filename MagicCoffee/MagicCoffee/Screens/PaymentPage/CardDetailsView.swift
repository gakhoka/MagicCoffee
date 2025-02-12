//
//  CardDetailsView.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 25.01.25.
//

import SwiftUI


struct CardDetailsView: View {
    @ObservedObject var cardsViewModel: CreditCardViewmodel
    @Environment(\.dismiss) var dismiss
    @State private var cardHolderName = ""
    @State private var cardNumber = ""
    @State private var expirationDate = ""
    @State private var cvv = ""
    @State private var detailsNeeded = false
    @State private var isVisa = true
    
    var body: some View {
        VStack(spacing: 30) {
            
            addingCardAlert
            
            Text("Enter Card Details")
                .poppinsFont(size: 18)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(LinearGradient(colors: [.cubeColor, .nardoGray, .creamColor], startPoint: .topLeading, endPoint: .bottomTrailing))
                
                VStack(spacing: 35) {
                    
                    HStack {
                        cardNumberField
                        cardType
                    }
                    
                    HStack {
                        TextField("MM/YY", text: $expirationDate)
                            .onChange(of: expirationDate) { newValue in
                                expirationDate = newValue.formattedExpirationDate()
                            }
                        
                        HStack {
                            TextField("CVV", text: $cvv)
                                .frame(width: 50)
                                .onChange(of: cvv) { newValue in
                                    cvv = String(newValue.filter { $0.isNumber }
                                        .prefix(3))
                                }
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundStyle(.white)
                        }
                    }
                    TextField("Cardholder Name", text: $cardHolderName)
                }
                .padding()
            }
            .poppinsFont(size: 18)
            .foregroundColor(.white)
            .frame(height: 200)
            
            saveButton
            
            Spacer()
        }
        .customBackButton {
            dismiss()
        }
        .padding()
    }
    
    private var cardNumberField: some View {
        TextField("XXXX XXXX XXXX XXXX", text: $cardNumber)
            .onChange(of: cardNumber) { newValue in
                let digits = newValue.filter { $0.isNumber }
                
                cardNumber = newValue.formattedCardNumber()
                
                if let firstDigit = digits.first {
                    isVisa = firstDigit == "4"
                }
            }
    }
    
    private var cardType: some View {
        Image(isVisa ? "visacard" : "masterlogo")
            .resizable()
            .renderingMode(isVisa ? .template : .original)
            .foregroundColor(.white)
            .frame(width: isVisa ? 50 : 76, height: 50)
            .animation(.easeInOut(duration: 0.5), value: isVisa)
    }
    
    private var addingCardAlert: some View {
        Text(detailsNeeded ? "Please fill all fields correctly" : (cardsViewModel.cardSaved ? "Card saved successfully" : ""))
            .foregroundColor(cardsViewModel.cardSaved ? .green : .red)
            .padding(.top)
            .animation(.easeIn(duration: 0.3), value: cardsViewModel.cardSaved)
            .animation(.easeIn(duration: 0.3), value: detailsNeeded)
    }
    
    private var saveButton: some View {
        Button(action: {
            if !cardNumber.isEmpty && !cardHolderName.isEmpty && !expirationDate.isEmpty && !cvv.isEmpty {
                
                let card = CreditCard(cardNumber: cardNumber, cardHolderName: cardHolderName, expirationDate: expirationDate, cvv: cvv)
                withAnimation {
                    cardsViewModel.addCreditCard(card)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    cardsViewModel.cardSaved = false
                }
            } else {
                detailsNeeded = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    detailsNeeded = false
                }
            }
        }) {
            Text("Save Card")
                .foregroundStyle(.white)
                .roundedRectangleStyle(color: .navyGreen)
                .frame(width: 250, height: 50)
                .poppinsFont(size: 16)
        }
        .padding(.top)
    }
}

#Preview {
    CardDetailsView(cardsViewModel: CreditCardViewmodel())
}
