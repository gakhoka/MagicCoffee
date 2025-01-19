//
//  OrderViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 18.01.25.
//


import SwiftUI

class OrderViewModel: ObservableObject {
    @Published var coffeeCount = 1
    @Published var isOn = false
    @Published var isTakeAway = true
    @Published var coffeeName = ""
    @Published var numberOfCoffees = 1
    @Published var volumeSize = 1
    @Published var ristrettoSize = 1
    @Published var cupData: [String: Int] = ["smallCup": 250, "mediumCup": 350, "largeCup": 450]
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
    
}

