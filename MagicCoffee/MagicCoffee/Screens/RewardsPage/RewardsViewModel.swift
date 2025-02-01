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
    @Published var coffeeHistory: [Order] = []
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
            
            userRef.getDocument { [weak self] snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let snapshot = snapshot, snapshot.exists {
                    self?.userPoints = snapshot.get("score") as? Int ?? 0
                }
            }
            
            let ordersRef = userRef.collection("orders")
            ordersRef.getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let snapshot = snapshot {
                    self?.userOrderCount = snapshot.count
                    
                    var orderList: [Order] = [] // Store Order objects
                    
                    for document in snapshot.documents {
                        if let coffeeArray = document.get("coffee") as? [[String: Any]] {
                            var coffeeList: [Coffee] = []
                            let orderDate = (document.get("orderDate") as? Timestamp)?.dateValue() ?? Date()
                            let prepareTime = (document.get("prepareTime") as? Timestamp)?.dateValue() ?? Date()
                            
                            for coffee in coffeeArray {
                                if let name = coffee["name"] as? String,
                                   let score = coffee["score"] as? Int {
                                    let myCoffee = Coffee(name: name, score: score)
                                    coffeeList.append(myCoffee)
                                }
                            }
                            
                            let order = Order(coffeeAmount: coffeeList.count, isTakeAway: true, price: 0.0, coffee: coffeeList, prepareTime: prepareTime, orderDate: orderDate)
                            orderList.append(order)
                        }
                    }
                    
                    // Sort by order date
                    self?.coffeeHistory = orderList.sorted { $0.orderDate > $1.orderDate }
                }
            }
        }
        
        func getCoffeeFromOrder(order: Order) -> [String] {
            // Function to extract coffee names from an order
            return order.coffee.map { $0.name }
        }
    
    
    func fetchRedeemableCoffees() {
        let dataBase = Firestore.firestore()
        let referrence = dataBase.collection("Coffees")
        referrence.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            var coffees: [Coffee] = []
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let name = data["name"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    let redeemPointsAmount = data["redeemPointsAmount"] as? Int ?? 0
                    
                    let coffee = Coffee(name: name, image: image, redeemPointsAmount: redeemPointsAmount)
                    coffees.append(coffee)
                    let sortedCoffees = coffees.sorted { $0.redeemPointsAmount > $1.redeemPointsAmount }
                    self?.freeCoffees = sortedCoffees
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
        } else {
            notEnoughPoints = true
        }
    }
}
