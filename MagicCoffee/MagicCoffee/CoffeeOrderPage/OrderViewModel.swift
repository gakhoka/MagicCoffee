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
    var coffees: [Coffee] = []
    var coffeeCountries: [Country] = Bundle.main.decode("countries.json")
    @Published var coffeeCount = 1
    @Published var coffeePrice = 0.0
    @Published var isOn = false
    @Published var isTakeAway = true
    @Published var coffeeName = ""
    @Published var numberOfCoffees = 1
    @Published var volumeSize = 1
    @Published var ristrettoSize = 1
    @Published var cupData = ["smallCup": 1, "mediumCup": 2, "largeCup": 3]
    @Published var selectedGrindSize =  0
    @Published var selectedRoastAmount = 2
    @Published var selectedIceAmount = 0
    @Published var isGrindingSelected = false
    @Published var coffeeType = 0.5
    @Published var selectedMilk = ""
    @Published var selectedSyrup = ""
    @Published var isMilkSelectionTapped = false
    @Published var isSyrupSelectionTapped = false
    @Published var milkTypes = ["None", "Regular", "Lactose-free", "Skimmed", "Vegetable"]
    @Published var syrupTypes = ["None", "Amaretto", "Coconut", "Vanilla", "Caramel"]
    @Published var additives = ["Ceylon cinnamon", "Grated chocolate", "Liquid chocolate", "Marshmallow", "Whipped cream", "Cream", "Nutmeg", "Ice cream"]
    @Published var selectedAdditives = [String]()
    @Published var selectedCity = ""
    @Published var coffeeImage = ""
    @Published var total = 0.0
    @Published var totalcoffeeCount = 0
    private var previousMilk = "None"
    private var previousSyrup = "None"

    
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
    
    func placeOrder() {
        uploadOrderToFirebase(order: createOrder()) { result in
            switch result {
            case .success(_):
                print("order is sent")
                print(self.totalcoffeeCount)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func addCoffee() {
        let coffee = createCoffee()
        coffees.append(coffee)
        updateTotalPrice()
        updateTotalCoffeeCount()
    }
    
    private func createCoffee() -> Coffee {
        let coffee = Coffee(count: coffeeCount, name: coffeeName, ristreto: ristrettoSize, size: Coffee.CoffeeSize(intValue: volumeSize) ?? .medium, image: coffeeImage, sortByOrigin: selectedCity, grinding: Coffee.GrindingLevel(intValue: selectedGrindSize) ?? .fine, milk: selectedMilk, syrup: selectedSyrup, iceAmount: selectedIceAmount, roastingLevel: Coffee.RoastingLevel(selectedRoastAmount) ?? .low, additives: selectedAdditives, score: Int(coffeePrice) * 5, price: coffeePrice, orderDate: Date.now)
        return coffee
        
    }
    
     func createOrder() -> Order {
        let order = Order(coffeeAmount: totalcoffeeCount, isTakeAway: isTakeAway, price: total, coffee: coffees)
        return order
    }
    
    func resetCoffee(coffee: Coffee) {
        coffeeName = coffee.name
        coffeePrice = coffee.price
        coffeeCount = 1
        volumeSize = 1
        ristrettoSize = 1
        selectedAdditives = [""]
        selectedCity = ""
        selectedSyrup = ""
        selectedMilk = ""
        selectedGrindSize = 1
        selectedIceAmount = 1
        selectedRoastAmount = 1
        coffeeType = 0.5
    }
    
    private func updateTotalCoffeeCount() {
        let totalCoffees = coffees.reduce(0) { partialResult, coffee in
            partialResult + coffee.count
        }
        
        totalcoffeeCount = totalCoffees
    }
    
    func removeOrder(_ coffee: Coffee) {
        coffees.removeAll { $0.id == coffee.id }
        updateTotalCoffeeCount()
        updateTotalPrice()
    }
    
    private func updateTotalPrice() {
        let sumOfPrices = coffees.reduce(0.0) { partialResult, coffee in
            partialResult + coffee.price
        }
        total = sumOfPrices
    }
    
    func updatePriceForMilk(_ milkType: String) {

        if previousMilk == "None" && milkType != "None" {
            coffeePrice += 0.5 * Double(coffeeCount)
        }
        else if previousMilk != "None" && milkType == "None" {
            coffeePrice -= 0.5 * Double(coffeeCount)
        }
        
        previousMilk = selectedMilk
        selectedMilk = milkType
    }
    
    func updatePriceForSyrup(_ syrupType: String) {

        if previousSyrup == "None" && syrupType != "None" {
            coffeePrice += 0.1 * Double(coffeeCount)
        }
        else if previousSyrup != "None" && syrupType == "None" {
            coffeePrice -= 0.1 * Double(coffeeCount)
        }
        
        previousSyrup = selectedSyrup
        selectedSyrup = syrupType
    }

    
    func updatePriceForSize(newSize: Int) {
        let oldSize = volumeSize
        
        if oldSize == 2 {
            coffeePrice -= 0.5 * Double(coffeeCount)
        } else if oldSize == 3 {
            coffeePrice -= 1.0 * Double(coffeeCount)
        }
        
        if newSize == 2 {
            coffeePrice += 0.5 * Double(coffeeCount)
        } else if newSize == 3 {
            coffeePrice += 1.0 * Double(coffeeCount)
        }
        volumeSize = newSize
    }
    
    func updateRistrettoOption(option: Int) {
        let oldRistretto = ristrettoSize
          
        if oldRistretto == 2 {
            coffeePrice -= 0.3 * Double(coffeeCount)
          }
          
          if option == 2 {
              coffeePrice += 0.3 * Double(coffeeCount)
          }
          
        ristrettoSize = option
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
            coffeePrice -= 0.3 * Double(coffeeCount)
        } else {
            selectedAdditives.append(additive)
            coffeePrice += 0.3 * Double(coffeeCount)
        }
    }
}

