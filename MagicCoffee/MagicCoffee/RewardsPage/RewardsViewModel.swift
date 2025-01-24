//
//  RewardsViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 23.01.25.
//


import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class RewardsViewModel: ObservableObject {
    
    @Published var userOrderCount = 0
    @Published var userPoints = 0
    
    init() {
        fetchUserOrders()
    }
    
    func fetchUserOrders() {
        let database = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let referrnce = database.collection("users").document(uid).collection("orders")
        
        referrnce.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                self?.userOrderCount = snapshot.count
                
                var totalPoints = 0
                for document in snapshot.documents {
                    if let coffees = document.get("coffee") as? [[String: Any]] {
                        for coffee in coffees {
                            if let score = coffee["score"] as? Int {
                                totalPoints += score
                                self?.userPoints = totalPoints
                            }
                        }
                    }
                }
            }
        }
    }
}
