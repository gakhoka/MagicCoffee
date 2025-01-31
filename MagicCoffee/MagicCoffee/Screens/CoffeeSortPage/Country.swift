//
//  CoffeeSort.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation

struct Country: Identifiable, Codable {
    var id = UUID()
    let name: String
    let cities: [City]
    
    struct City: Identifiable, Codable {
        var id = UUID()
        let name: String
    }
}


