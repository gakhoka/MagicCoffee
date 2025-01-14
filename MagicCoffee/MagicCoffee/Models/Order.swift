//
//  Order.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct Order: Identifiable {
    let id = UUID()
    let coffeeAmount: Int
    let isTakeAway: Bool
    let price: Int
    let coffee: [Coffee]
    let barista: [Barista]
}
