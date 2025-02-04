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
    @Published var cupSize = ["smallCup": 1, "mediumCup": 2, "largeCup": 3]
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
    @Published var freeCoffees = 0
    @Published var userOrderCount = 0
    private var previousMilk = "None"
    private var previousSyrup = "None"
    

    
    //MARK: order

    func uploadOrderToFirebase(order: Order,completion: @escaping (Result<Void, Error>) -> Void) {
        guard  let currentUser = Auth.auth().currentUser else { return }
        
        let userId = currentUser.uid
        let database = Firestore.firestore()
        let userOrdersRef = database.collection("users").document(userId).collection("orders")
        let userRef = database.collection("users").document(userId)
        
        let orderData = order.asDictionary()
        
        userOrdersRef.addDocument(data: orderData) { [weak self] error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
                self?.showNotification()
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

    private func createCoffee() -> Coffee {
        let coffee = Coffee(count: coffeeCount, name: coffeeName, ristreto: ristrettoSize, size: Coffee.CoffeeSize(volumeSize) ?? .medium, image: coffeeImage, sortByOrigin: selectedCity, grinding: Coffee.GrindingLevel(selectedGrindSize) ?? .fine, milk: selectedMilk, syrup: selectedSyrup, iceAmount: selectedIceAmount, roastingLevel: Coffee.RoastingLevel(selectedRoastAmount) ?? .low, additives: selectedAdditives, score: Int(coffeePrice) * 5, price: isGiftCoffeeSelected ? 0.0 : coffeePrice)
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
    
    private func createOrder() -> Order {
        let order = Order(coffeeAmount: totalcoffeeCount, isTakeAway: isTakeAway, price: total, coffee: coffees, prepareTime: prepareTime(), orderDate: orderDate)
        return order
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    self?.coffees.removeAll()
                }
                self?.total = 0.0
                self?.isGiftCoffeeSelected = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func removeOrder(_ coffee: Coffee) {
        coffees.removeAll { $0.id == coffee.id }
        updateTotalCoffeeCount()
        updateTotalPrice()
    }
    
    private func showNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Your order is ready! ☕"
        content.body = "Please collect"
        content.sound = .default

        let triggerTime = TimeInterval(prepareTime().timeIntervalSinceNow)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(1, triggerTime), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { [weak self] error in
            guard self != nil else { return }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func addCoffee() {
        if coffeeName == "" {
            return
        }
        
        if coffees.first(where: {
            $0.name == coffeeName &&
            $0.size == Coffee.CoffeeSize(volumeSize) &&
            $0.grinding == Coffee.GrindingLevel(selectedGrindSize) &&
            $0.milk == selectedMilk &&
            $0.syrup == selectedSyrup &&
            $0.iceAmount == selectedIceAmount &&
            $0.roastingLevel == Coffee.RoastingLevel(selectedRoastAmount) &&
            $0.additives == selectedAdditives &&
            $0.sortByOrigin  == selectedCity
        }) != nil {
                return
            }
        
        let coffee = createCoffee()
        coffees.append(coffee)
        updateTotalPrice()
        updateTotalCoffeeCount()
    }
    
    //MARK: Free coffee
    
    func getFreeCoffee() {
        if freeCoffees > 0 {
            isGiftCoffeeSelected = true
            freeCoffees -= 1
            saveFreeCoffeesToFirestore()
        } else {
            isGiftCoffeeSelected.toggle()
        }
    }
    
    func fetchUserFreeCoffees() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let database = Firestore.firestore()
        let userRef = database.collection("users").document(userId)
        
        userRef.getDocument { [weak self] document, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                self?.freeCoffees = data?["freeCoffees"] as? Int ?? 0
            }
        }
    }
    
    func saveFreeCoffeesToFirestore() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let database = Firestore.firestore()
        let userRef = database.collection("users").document(userId)
        
        userRef.updateData(["freeCoffees": freeCoffees]) { [weak self] error in
            guard self != nil else { return }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveFreeCoffees() {
        if userOrderCount > 0 && (userOrderCount - 7) % 8 == 0 {
            freeCoffees += 1
            saveFreeCoffeesToFirestore()
        }
    }
    
    func addRedeemedCoffee(_ coffee: Coffee) {
        coffees.append(coffee)
    }
    
    //MARK: Countries
    
    
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
            
            DispatchQueue.main.async { [weak self] in
                self?.coffeeCountries = fetchedCountries
            }
        }
    }
    
    //MARK: USER
    
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
    
    //MARK: Coffee price calc
    
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

