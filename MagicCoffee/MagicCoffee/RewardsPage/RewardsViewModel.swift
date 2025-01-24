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
    @Published var coffeeHistory: [Coffee] = []
    
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
                var coffeeList: [Coffee] = []

                for document in snapshot.documents {
                    if let coffees = document.get("coffee") as? [[String: Any]] {
                        for coffee in coffees {
                            if let score = coffee["score"] as? Int,
                               let name = coffee["name"] as? String {
                                let mycoffe = Coffee(count: 1, name: name, ristreto: 1, size: .large, image: "", sortByOrigin: "", grinding: .fine, milk: "", syrup: "", iceAmount: 0, roastingLevel: .high, additives: [""], score: score, redeemPointsAmount: 0, validityDate: "", price: 0)
                                totalPoints += score
                                self?.userPoints = totalPoints
                                coffeeList.append(mycoffe)
                                self?.coffeeHistory = coffeeList
                            }
                        }
                    }
                }
            }
        }
    }
}
