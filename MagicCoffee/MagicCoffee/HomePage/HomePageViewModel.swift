//
//  HomePageViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 17.01.25.
//

import FirebaseFirestore
import SwiftUI


class HomePageViewModel: ObservableObject {
    @Published var coffees: [Coffee] = []
    
    
    init() {
        fetchCoffees()
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
                        validityDate: validityDate
                    )
                    
                    self.coffees.append(coffee)
                }
            }
        }
    }
}
