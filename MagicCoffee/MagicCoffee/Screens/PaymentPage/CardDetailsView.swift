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
    
    var body: some View {
        VStack(spacing: 20) {
            Text(cardsViewModel.cardSaved ? "Card successfully added" : "")
                .foregroundColor(.navyGreen)
                .animation(.easeIn(duration: 0.3), value: cardsViewModel.cardSaved)
            Spacer()
            
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
            
            Button(action: {
                let card = CreditCard(cardNumber: cardNumber, cardHolderName: cardHolderName, expirationDate: expirationDate, cvv: cvv)
                cardsViewModel.addCreditCard(card)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    cardsViewModel.cardSaved = false
                }
            }) {
                Text("Save Card")
                    .foregroundStyle(.white)
                    .roundedRectangleStyle(color: .navyGreen)
                    .frame(width: 300, height: 60)
            }
            Spacer()
        }
        .customBackButton {
            dismiss()
        }
        .poppinsFont(size: 16)
        .padding()
    }
}

#Preview {
    CardDetailsView(cardsViewModel: CreditCardViewmodel())
}
