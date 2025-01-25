//
//  Card.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 25.01.25.
//

import SwiftUI

struct CreditCard: Codable, Identifiable {
    var id = UUID()
    var cardNumber: String
    var cardHolderName: String
    var expirationDate: String
    var cvv: String
}
