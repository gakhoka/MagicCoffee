//
//  CoffeeSort.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct Country: Identifiable {
    let id = UUID()
    let name: String
    let coffeeTypes: [CoffeeType]
}

struct CoffeeType: Identifiable {
    let id = UUID()
    let name: String
}



