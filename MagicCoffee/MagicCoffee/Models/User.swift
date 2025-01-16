//
//  User.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct User: Identifiable {
    let id = UUID()
    let username: String
    let email: String
    let orders: [Order] = []
    let points: Int? = 0
}
