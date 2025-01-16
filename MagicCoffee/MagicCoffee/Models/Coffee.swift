//
//  Coffee.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct Coffee: Identifiable {
    let id = UUID()
    let name: String
    let ristreto: Int
    let size: CoffeeSize
    let image: String
    let sort: [Country]
    let grinding: GrindingLevel
    let milk: [String]?
    let syrup: [String]?
    let iceAmount: Int
    let roastingLevel: Int
    let additives: [String]?
    let score: Int
    let redeemPointsAmount: Int
    let validityDate: String
    
    
    enum CoffeeSize: String {
        case small, medium, large
    }

    enum GrindingLevel: Int {
        case fine = 0, medium
    }
}



