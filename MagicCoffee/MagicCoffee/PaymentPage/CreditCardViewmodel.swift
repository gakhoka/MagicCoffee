//
//  CreditCardViewmodel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 25.01.25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class CreditCardViewmodel: ObservableObject {
    @Published var total: Double = 0.0
    @Published var user: User?
    @Published var userCards: [CreditCard] = []
    
    func getGreditCard() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let database = Firestore.firestore()
        let referrence = database.collection("users").document(uid).collection("creditCards")
        
        referrence.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
            
                    let cardNumber = data["cardNumber"] as? String ?? "no"
                    let cardHolderName = data["cardHolderName"] as? String ?? "w"
                    let expirationDate = data["expirationDate"] as? String ?? "no"
                    let cvv = data["cvv"] as? String ?? ""
                    
                    let creditCard = CreditCard(cardNumber: cardNumber, cardHolderName: cardHolderName, expirationDate: expirationDate, cvv: cvv)
                    
                    self?.userCards.append(creditCard)
                }
            }
        }

    }

    
    func addCreditCard(_ card: CreditCard) {
        user?.creditCards.append(card)
        
        guard let currentUser = Auth.auth().currentUser else { return}
        
        let userId = currentUser.uid
        let db = Firestore.firestore()
        let creditCardsRef = db.collection("users").document(userId).collection("creditCards")
        
        let cardData: [String: Any] = [
            "cardNumber": card.cardNumber,
            "expiryDate": card.expirationDate,
            "cardHolderName": card.cardHolderName,
            "cvv": card.cvv
        ]
        
        creditCardsRef.addDocument(data: cardData) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Credit card successfully added to Firestore!")
            }
        }
    }
}
