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
    
    var coffeeHistory: [Coffee] = []
    
    init() {
        fetchOrders()
    }
    
    var updateCoffees: (() -> Void)?
    
    func fetchOrders() {
        let database = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userRef = database.collection("users").document(uid)
        
        userRef.getDocument { document, error in
            if let error = error {
                print("Error fetching user document: \(error.localizedDescription)")
                return
            }
            print("Fetched user document: \(String(describing: document?.data()))")
        }
        
        let ordersRef = userRef.collection("orders")
        ordersRef.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching orders: \(error.localizedDescription)")
                return
            }
            
            if let snapshot = snapshot {
            
                
                var coffeeList: [Coffee] = []
                for document in snapshot.documents {
                    print("Order document data: \(document.data())")
                    
                    if let coffees = document.get("coffee") as? [[String: Any]] {
                        for coffee in coffees {
                            if let name = coffee["name"] as? String,
                               let timestamp = coffee["orderDate"] as? Timestamp,
                               let size = coffee["size"] as? String,
                               let price = coffee["price"] as? Double {
                                let orderDate = timestamp.dateValue()
                                let myCoffee = Coffee(name: name, size: Coffee.CoffeeSize(rawValue: size) ?? .large, price: price, orderDate: orderDate)
                                coffeeList.append(myCoffee)
                                print("Added coffee: \(myCoffee)")
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.coffeeHistory = coffeeList.sorted { $0.orderDate > $1.orderDate }
                    self?.updateCoffees?()
                }
            }
        }
    }

}
