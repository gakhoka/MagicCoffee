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
    @Published var username = ""
    @Published var showErrorMessage = false
    
    

    func fetchCoffees() {
        
        if !coffees.isEmpty {
            return
        }
        
        let dataBase = Firestore.firestore()
        let referrence = dataBase.collection("Coffees")
        referrence.getDocuments { [weak self] snapshot, error in
            if let error = error {
                self?.showErrorMessage = true
                print(error.localizedDescription)
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let name = data["name"] as? String ?? ""
                    let image = data["image"] as? String ?? ""
                    let price = data["price"] as? Double ?? 0.0
                    
                    let coffee = Coffee(name: name, image: image, price: price)
                    self?.coffees.append(coffee)
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
                    
            self?.username = data["username"] as? String ?? "No username"
            
            UserDefaults.standard.set(self?.username, forKey: "username")
        }
    }
}
