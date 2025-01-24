//
//  HomePageViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 17.01.25.
//

import FirebaseFirestore
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class HomePageViewModel: ObservableObject {
    @Published var coffees: [Coffee] = []
    @Published var user: User?
    
    init() {
        fetchCoffees()
        fetchUser()
    }
    
    func fetchCoffees() {
        let dataBase = Firestore.firestore()
        let referrence = dataBase.collection("Coffees")
        referrence.getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let name = data["name"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    let price = data["price"] as? Double ?? 0.0
                    
                    let coffee = Coffee(
                        count: 0, name: name, ristreto: 1, size: .large, image: image, sortByOrigin: "", grinding: .fine, milk: "", syrup: "", iceAmount: 1, roastingLevel: .high, additives: [""], score: 1, redeemPointsAmount: 1, validityDate: "", price: price, orderDate: Date.now)
                    self.coffees.append(coffee)
                }
            }
        }
    }
    
    
    func fetchUser() {
        let database = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        database.collection("users").document(uid).getDocument { [weak self] document, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let document = document, document.exists,
                  let data = document.data() else {
                return
            }
            
            print(data)
            
            if let userData = document.data() {
                if let currentUser = try? Firestore.Decoder().decode(User.self, from: userData) {
                    self?.user = currentUser
                }
            }
        }
    }
    
    var username: String {
        if let displayName = user?.username {
            return displayName
        }
        return ""
    }
}
