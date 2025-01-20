//
//  Order.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct Order: Identifiable, Codable {
    var id = UUID()
    let coffeeAmount: Int
    let isTakeAway: Bool
    let price: Int
    let coffee: [Coffee]
}
