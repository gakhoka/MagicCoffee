//
//  HistoryViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 28.01.25.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

class HistoryViewModel {
    
    var ordersHistory: [Order] = []
    var ongoingOrder: [Order] = []
    
    init() {
        fetchOrders()
    }
    
    var updateCoffees: (() -> Void)?
    
    func fetchOrders() {
        let database = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ordersRef = database.collection("users").document(uid).collection("orders")
        
        ordersRef.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                
                var historyList: [Order] = []
                var ongoingList: [Order] = []
                
                for document in snapshot.documents {
                    if let coffeeData = document.get("coffee") as? [[String: Any]] {
                        var coffees: [Coffee] = []
                        
                        for coffee in coffeeData {
                            if let name = coffee["name"] as? String,
                               let size = coffee["size"] as? String,
                               let grinding = coffee["grinding"] as? String,
                               let milk = coffee["milk"] as? String,
                               let roasting = coffee["roastingLevel"] as? String,
                               let price = coffee["price"] as? Double {
                        
                                let myCoffee = Coffee(
                                    name: name,
                                    size: Coffee.CoffeeSize(rawValue: size) ?? .large,
                                    grinding: Coffee.GrindingLevel(rawValue: grinding) ?? .medium,
                                    milk: milk,
                                    roastingLevel: Coffee.RoastingLevel(rawValue: roasting) ?? .low,
                                    price: price
                                )
                                coffees.append(myCoffee)
                            }
                        }
                        
                        if let coffeeAmount = document.get("coffeeAmount") as? Int,
                           let isTakeAway = document.get("isTakeAway") as? Bool,
                           let price = document.get("price") as? Double,
                           let prepareTime = document.get("prepareTime") as? Timestamp,
                           let orderDate = document.get("orderDate") as? Timestamp {
                            let order = Order(coffeeAmount: coffeeAmount, isTakeAway: isTakeAway, price: price, coffee: coffees, prepareTime: prepareTime.dateValue(), orderDate: orderDate.dateValue())
                            
                            if order.prepareTime > Date.now {
                                ongoingList.append(order)
                            } else {
                                historyList.append(order)
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.ongoingOrder = ongoingList.sorted { $0.prepareTime < $1.prepareTime }
                    self?.ordersHistory = historyList.sorted { $0.orderDate > $1.orderDate }
                    self?.updateCoffees?()
                }
            }
        }
    }
}
