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
    @Published var freeCoffees: [Coffee] = []
    @Published var isCoffeeRedeemed = false
    @Published var notEnoughPoints = false
    
    var orderViewModel: OrderViewModel
    
    init(orderViewModel: OrderViewModel) {
        self.orderViewModel = orderViewModel
        fetchUserOrders()
    }
    
    func fetchUserOrders() {
        let database = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userRef = database.collection("users").document(uid)
        
        userRef.getDocument { [weak self] document, error in
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                self?.userPoints = document.get("score") as? Int ?? 0
            }
        }
        
        let ordersRef = userRef.collection("orders")
        ordersRef.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching orders: \(error.localizedDescription)")
                return
            }
            
            if let snapshot = snapshot {
                self?.userOrderCount = snapshot.count
                
                var coffeeList: [Coffee] = []
                for document in snapshot.documents {
                    if let coffees = document.get("coffee") as? [[String: Any]] {
                        for coffee in coffees {
                            if let score = coffee["score"] as? Int,
                               let name = coffee["name"] as? String,
                               let timestamp = coffee["orderDate"] as? Timestamp {
                                let orderDate = timestamp.dateValue()
                                let myCoffee = Coffee(name: name, score: score, orderDate: orderDate)
                                coffeeList.append(myCoffee)
                            }
                        }
                    }
                }
                self?.coffeeHistory = coffeeList.sorted { $0.orderDate > $1.orderDate }
            }
        }
    }
    
    
    func fetchRedeemableCoffees() {
        let dataBase = Firestore.firestore()
        let referrence = dataBase.collection("Coffees")
        referrence.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let name = data["name"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    let redeemPointsAmount = data["redeemPointsAmount"] as? Int ?? 0
                    
                    let coffee = Coffee(name: name, image: image, redeemPointsAmount: redeemPointsAmount)
                    self?.freeCoffees.append(coffee)
                }
            }
        }
    }
    
    func updateUserScore() {
        let database = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userRef = database.collection("users").document(uid)
        
        userRef.updateData(["score": userPoints]) { [weak self] error in
            guard self != nil else { return }
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Score updated")
            }
        }
    }
    
    func redeemCoffee(coffee: Coffee) {
        if userPoints >= coffee.redeemPointsAmount {
            isCoffeeRedeemed = true
            userPoints -= coffee.redeemPointsAmount
            orderViewModel.coffees.append(coffee)
            updateUserScore()
            if let index = freeCoffees.firstIndex(where: { $0.name == coffee.name }) {
                freeCoffees.remove(at: index)
            }
        } else {
            notEnoughPoints = true
        }
    }
}
