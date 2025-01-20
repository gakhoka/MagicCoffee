//
//  OrderViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 18.01.25.
//

import FirebaseFirestore
import SwiftUI
import FirebaseAuth

class OrderViewModel: ObservableObject {
    var coffeeCountries: [Country] = Bundle.main.decode("countries.json")
    @Published var coffeeCount = 1
    @Published var isOn = false
    @Published var isTakeAway = true
    @Published var coffeeName = ""
    @Published var numberOfCoffees = 1
    @Published var volumeSize = 1
    @Published var ristrettoSize = 1
    @Published var cupData = ["smallCup": 250, "mediumCup": 350, "largeCup": 450]
    @Published var selectedGrindSize =  0
    @Published var selectedRoastAmount = 1
    @Published var selectedIceAmount = 1
    @Published var isGrindingSelected = false
    @Published var value = 0.5
    @Published var selectedMilk = ""
    @Published var selectedSyrup = ""
    @Published var isMilkSelectionTapped = false
    @Published var isSyrupSelectionTapped = false
    @Published var milkTypes = ["None", "Cow's", "Lactose-free", "Skimmed", "Vegetable"]
    @Published var syrupTypes = ["None", "Amaretto", "Coconut", "Vanilla", "Caramel"]
    @Published var additives = ["Ceylon cinnamon", "Grated chocolate", "Liquid chocolate", "Marshmallow", "Whipped cream", "Cream", "Nutmeg", "Ice cream"]
    @Published var selectedAdditives = [String]()
    @Published var selectedCity = ""
    
    
    func uploadOrderToFirebase(order: Order,completion: @escaping (Result<Void, Error>) -> Void) {
        guard  let currentUser = Auth.auth().currentUser else { return }
        
        let userId = currentUser.uid
        let db = Firestore.firestore()
        let userOrdersRef = db.collection("users").document(userId).collection("orders")
        
        let orderData = order.asDictionary()
        
        userOrdersRef.addDocument(data: orderData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func createOrder() -> Order {
        var coffees: [Coffee] = []
        
        let coffee = Coffee(name: coffeeName, ristreto: ristrettoSize, size: Coffee.CoffeeSize(intValue: volumeSize) ?? .small, image: "", sortByOrigin: selectedCity, grinding: Coffee.GrindingLevel(intValue: selectedGrindSize) ?? .fine, milk: selectedMilk, syrup: selectedSyrup, iceAmount: selectedIceAmount, roastingLevel: Coffee.RoastingLevel(selectedRoastAmount) ?? .low, additives: selectedAdditives, score: 2, redeemPointsAmount: 0, validityDate: "", price: 5)
        
        coffees.append(coffee)
        
        let order = Order(coffeeAmount: coffeeCount, isTakeAway: isTakeAway, price: 19, coffee: coffees)
        return order
    }
    
     func toggleCitySelection(_ city: String) {
        if selectedCity == city {
           selectedCity = ""
        } else {
            selectedCity = city
        }
    }
    
     func toggleAdditiveSelection(_ additive: String) {
        if selectedAdditives.contains(additive) {
            selectedAdditives.removeAll { $0 == additive }
        } else {
            selectedAdditives.append(additive)
        }
    }
}

