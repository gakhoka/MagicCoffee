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
    @State private var cardHolderName: String = ""
    @State private var cardNumber: String = ""
    @State private var expirationDate: String = ""
    @State private var cvv: String = ""
    @State private var detailsNeeded = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            addingCardAlert
            
            Text("Enter Card Details")
                
            TextField("Cardholder Name", text: $cardHolderName)
                .cardTextField()
            
            TextField("Card Number", text: $cardNumber)
                .cardTextField()
            
            HStack(spacing: 15) {
                TextField("MM/YY", text: $expirationDate)
                    .cardTextField()
                
                SecureField("CVV", text: $cvv)
                    .cardTextField()
            }
            
           saveButton
            
            Spacer()
        }
        .customBackButton {
            dismiss()
        }
        .poppinsFont(size: 16)
        .padding()
    }
    
    private var addingCardAlert: some View {
        Text(detailsNeeded ? "Please fill all fields correctly" : (cardsViewModel.cardSaved ? "Card saved successfully" : ""))
            .foregroundColor(.navyGreen)
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
                .frame(width: 300, height: 60)
        }
    }
}

#Preview {
    CardDetailsView(cardsViewModel: CreditCardViewmodel())
}
