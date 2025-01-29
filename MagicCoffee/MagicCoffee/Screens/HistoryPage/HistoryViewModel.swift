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
    
    var ordersHistory: [Coffee] = []
    var ongoingOrder: [Coffee] = []
    
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
                
                var historyList: [Coffee] = []
                var ongoingList: [Coffee] = []
                
                for document in snapshot.documents {

                    if let coffees = document.get("coffee") as? [[String: Any]] {
                        for coffee in coffees {
                            if let name = coffee["name"] as? String,
                               let prepTime = coffee["prepTime"] as? Timestamp,
                               let timestamp = coffee["orderDate"] as? Timestamp,
                               let size = coffee["size"] as? String,
                               let grinding = coffee["grinding"] as? String,
                               let milk = coffee["milk"] as? String,
                               let roasting = coffee["roastingLevel"] as? String,
                               let price = coffee["price"] as? Double {
                                let orderDate = timestamp.dateValue()
                                let prepDate = prepTime.dateValue()
                                let myCoffee = Coffee(name: name, size: Coffee.CoffeeSize(rawValue: size) ?? .large, grinding: Coffee.GrindingLevel(rawValue: grinding) ?? .medium, milk: milk, roastingLevel: Coffee.RoastingLevel(rawValue: roasting) ?? .low, price: price, orderDate: orderDate, prepTime: prepDate)
                                
                                if prepDate > Date.now {
                                    ongoingList.append(myCoffee)
                                } else {
                                    historyList.append(myCoffee)
                                }
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.ongoingOrder = ongoingList.sorted { $0.orderDate > $1.orderDate }
                    self?.ordersHistory = historyList.sorted { $0.orderDate > $1.orderDate }
                    self?.updateCoffees?()
                }
            }
        }
    }
}
