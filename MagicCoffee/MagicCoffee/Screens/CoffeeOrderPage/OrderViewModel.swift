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
    var coffeeCountries: [Country] = []
    
    @Published var coffeeCount = 1
    @Published var coffeePrice = 0.0
    @Published var isDatePickerOn = false
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
    @Published var selectedAdditives = [String]()
    @Published var selectedCity = ""
    @Published var coffeeImage = ""
    @Published var total = 0.0
    @Published var totalcoffeeCount = 0
    @Published var isGiftCoffeeSelected = false
    @Published var orderDate = Date.now
    @Published var pickDate = Date.now
    @Published var freeCoffees: Int {
        didSet {
            UserDefaults.standard.set(freeCoffees, forKey: "free")
        }
    }

    @Published var userOrderCount: Int {
        didSet {
            UserDefaults.standard.set(userOrderCount, forKey: "count")
        }
    }
    
    private var previousMilk = "None"
    private var previousSyrup = "None"
    
    
    init() {
        self.userOrderCount = UserDefaults.standard.integer(forKey: "count")
        self.freeCoffees = UserDefaults.standard.integer(forKey: "free")
    }
    
    func addRedeemedCoffee(_ coffee: Coffee) {
        coffees.append(coffee)
    }
    
    func fetchCountries() {
        let dataBase = Firestore.firestore()
        let reference = dataBase.collection("Countries")
        
        reference.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            var fetchedCountries: [Country] = []
            
            for document in snapshot.documents {
                let data = document.data()
                
                let name = data["name"] as? String ?? ""
                let cityNames = data["cities"] as? [String] ?? []
                let cities: [Country.City] = cityNames.map { Country.City(name: $0) }
                
                let country = Country(name: name, cities: cities)
                fetchedCountries.append(country)
            }
            
            DispatchQueue.main.async {
                self?.coffeeCountries = fetchedCountries
            }
        }
    }
    
    func uploadOrderToFirebase(order: Order,completion: @escaping (Result<Void, Error>) -> Void) {
        guard  let currentUser = Auth.auth().currentUser else { return }
        
        let userId = currentUser.uid
        let database = Firestore.firestore()
        let userOrdersRef = database.collection("users").document(userId).collection("orders")
        let userRef = database.collection("users").document(userId)
        
        let orderData = order.asDictionary()
        
        userOrdersRef.addDocument(data: orderData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
        
        userRef.updateData(["score": FieldValue.increment(Int64(total * 5))]) { [weak self] error in
            if let error = error {
                completion(.failure((error)))
            } else {
                completion(.success(()))
                self?.saveFreeCoffees()
            }
        }
    }

    
    func fetchUserOrders() {
        let database = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let referrnce = database.collection("users").document(uid).collection("orders")
        
        referrnce.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                self?.userOrderCount = snapshot.count
            }
        }
    }
    
    func placeOrder() {
        
        if isGiftCoffeeSelected {
            total = coffees.filter { $0.price > 0 }.reduce(0.0) { $0 + $1.price }
            freeCoffees -= 1
        } else {
            updateTotalPrice()
        }
        
        uploadOrderToFirebase(order: createOrder()) { [weak self] result in
            switch result {
            case .success(_):
                self?.coffees.removeAll()
                self?.total = 0.0
                self?.isGiftCoffeeSelected = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getFreeCoffee() {
        if freeCoffees > 0 {
            isGiftCoffeeSelected = true
            freeCoffees -= 1
        } else {
            isGiftCoffeeSelected.toggle()
        }
    }
    
    func addCoffee() {
        if coffees.first(where: { $0.name == coffeeName }) != nil && isGiftCoffeeSelected == false {
            return
        }
        
        let coffee = createCoffee()
        coffees.append(coffee)
        updateTotalPrice()
        updateTotalCoffeeCount()
    }
    
    private func createCoffee() -> Coffee {
        let coffee = Coffee(count: coffeeCount, name: coffeeName, ristreto: ristrettoSize, size: Coffee.CoffeeSize(intValue: volumeSize) ?? .medium, image: coffeeImage, sortByOrigin: selectedCity, grinding: Coffee.GrindingLevel(intValue: selectedGrindSize) ?? .fine, milk: selectedMilk, syrup: selectedSyrup, iceAmount: selectedIceAmount, roastingLevel: Coffee.RoastingLevel(selectedRoastAmount) ?? .low, additives: selectedAdditives, score: Int(coffeePrice) * 5, price: isGiftCoffeeSelected ? 0.0 : coffeePrice, orderDate: orderDate, prepTime: prepareTime())
        return coffee
    }
    
    func prepareTime() -> Date {
        if !isDatePickerOn {
            let date = orderDate.addingTimeInterval(TimeInterval(Double.random(in: 15...25) * 60.0))
            return date
        } else {
            return pickDate
        }
    }
    
    func saveFreeCoffees() {
        if userOrderCount > 0 && (userOrderCount - 7) % 8 == 0 {
            freeCoffees += 1
        }
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
        isDatePickerOn = false
        pickDate = Date.now
        
        isGiftCoffeeSelected = false
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

