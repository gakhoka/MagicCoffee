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
                    let ristreto = data["ristreto"] as? Int ?? 0
                    let sizeRaw = data["size"] as? String ?? "small"
                    let size = Coffee.CoffeeSize(rawValue: sizeRaw) ?? .small
                    let image = data["image"] as? String ?? ""
                    let sortRaw = data["sort"] as? [String] ?? []
                    let grindingRaw = data["grinding"] as? Int ?? 0
                    let grinding = Coffee.GrindingLevel(rawValue: grindingRaw) ?? .fine
                    let milk = data["milk"] as? [String]
                    let syrup = data["syrup"] as? [String]
                    let iceAmount = data["iceAmount"] as? Int ?? 0
                    let roastingLevel = data["roastingLevel"] as? Int ?? 0
                    let additives = data["additives"] as? [String]
                    let score = data["score"] as? Int ?? 0
                    let redeemPointsAmount = data["redeemPointsAmount"] as? Int ?? 0
                    let validityDate = data["validityDate"] as? String ?? ""
                    let price = data["price"] as? Int ?? 10
                    
                    let coffee = Coffee(
                        name: name,
                        ristreto: ristreto,
                        size: size,
                        image: image,
                        sort: sortRaw,
                        grinding: grinding,
                        milk: milk,
                        syrup: syrup,
                        iceAmount: iceAmount,
                        roastingLevel: roastingLevel,
                        additives: additives,
                        score: score,
                        redeemPointsAmount: redeemPointsAmount,
                        validityDate: validityDate,
                        price: price
                    )
                    
                    self.coffees.append(coffee)
                }
            }
        }
    }
    
    
    func fetchUser() {
        let database = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        database.collection("users").document(uid).getDocument { document, error in
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
                    self.user = currentUser
                }
            }
        }
    }
    
    var username: String {
        if let displayName = user?.username {
            return displayName
        }
        return "No username"
    }
}
