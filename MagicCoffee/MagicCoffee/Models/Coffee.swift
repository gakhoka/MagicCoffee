//
//  Coffee.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct Coffee: Identifiable, Codable {
    var id = UUID()
    let name: String
    let ristreto: Int
    let size: CoffeeSize
    let image: String
    let sort: [String]
    let grinding: GrindingLevel
    let milk: [String]?
    let syrup: [String]?
    let iceAmount: Int
    let roastingLevel: Int
    let additives: [String]?
    let score: Int
    let redeemPointsAmount: Int
    let validityDate: String
    let price: Int
    
    
    enum CoffeeSize: String, Codable {
        case small, medium, large
    }

    enum GrindingLevel: Int,Codable {
        case fine = 0, medium
    }
    
    static let example = Coffee(name: "", ristreto: 1, size: CoffeeSize.large, image: "Latte", sort: ["sd"], grinding: GrindingLevel.fine, milk: [""], syrup: [""], iceAmount: 1, roastingLevel: 1, additives: [""], score: 1, redeemPointsAmount: 200, validityDate: "", price: 6)
}



