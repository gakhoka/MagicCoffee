//
//  OrderViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 18.01.25.
//


import SwiftUI

class OrderViewModel: ObservableObject {
    @Published var coffeeCount = 2
    @Published var isOn = false
    @Published var isTakeAway = true
    @Published var coffeeName = ""
    @Published var numberOfCoffees = 1
    @Published var volumeSize = 1
    @Published var ristrettoSize = 1
    @Published var cupData: [String: Int] = ["smallCup": 250, "mediumCup": 350, "largeCup": 450]
}


