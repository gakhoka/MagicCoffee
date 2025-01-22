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
    let price: Double
    let coffee: [Coffee]
}

extension Order {
    func asDictionary() -> [String: Any] {
        return [
            "coffeeAmount": coffeeAmount,
            "isTakeAway": isTakeAway,
            "price": price,
            "coffee": coffee.map { $0.asDictionary() }
        ]
    }
}
