//
//  User.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct User: Identifiable, Codable {
    var id: String
    var username: String
    var email: String
    var orders: [Order] = []
    var points: Int? = 0
    var creditCard: [CreditCard] = []
    var freeCoffess = 0
}
