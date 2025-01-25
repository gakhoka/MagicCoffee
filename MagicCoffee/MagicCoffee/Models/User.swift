//
//  User.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct User: Identifiable, Codable {
    var id: String
    let username: String
    let email: String
    var orders: [Order] = []
    var points: Int? = 0
    var creditCards: [CreditCard] = []
}
