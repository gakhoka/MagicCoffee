//
//  User.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct User {
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let mobileNumber: String
    let orders: [Order]
    let points: Int
}
