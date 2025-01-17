//
//  RedeemViewModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 16.01.25.
//

import SwiftUI

class RedeemViewModel: ObservableObject {
    @Published var coffees: [Coffee] = []
    
    init() {
        createCoffee()
    }
    
    private func createCoffee() {
        let coffeeItems = [
            Coffee(
                name: "Latte",
                ristreto: 0,
                size: .medium,
                image: "coffee1",
                sort: [],
                grinding: .fine,
                milk: nil,
                syrup: nil,
                iceAmount: 0,
                roastingLevel: 0,
                additives: nil,
                score: 0,
                redeemPointsAmount: 1340,
                validityDate: "04.07.21", price: 2
            ),
            Coffee(
                name: "Cappuccino",
                ristreto: 0,
                size: .medium,
                image: "coffee1",
                sort: [],
                grinding: .fine,
                milk: nil,
                syrup: nil,
                iceAmount: 0,
                roastingLevel: 0,
                additives: nil,
                score: 0,
                redeemPointsAmount: 1340,
                validityDate: "04.07.21",
                price: 1
            )
        ]
        coffees.append(contentsOf: coffeeItems)
    }
}
