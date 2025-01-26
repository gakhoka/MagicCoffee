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
            Text("Enter Card Details")
                
            TextField("Cardholder Name", text: $cardHolderName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .autocapitalization(.words)
            
            TextField("Card Number", text: $cardNumber)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            HStack(spacing: 15) {
                TextField("MM/YY", text: $expirationDate)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
                
                SecureField("CVV", text: $cvv)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
            }
            
            Button(action: {
                let card = CreditCard(cardNumber: cardNumber, cardHolderName: cardHolderName, expirationDate: expirationDate, cvv: cvv)
                cardsViewModel.addCreditCard(card)
            }) {
                Text("Save Card")
                    .foregroundStyle(.white)
                    .roundedRectangleStyle(color: .navyGreen)
                    .frame(width: 300, height: 60)
            }
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
