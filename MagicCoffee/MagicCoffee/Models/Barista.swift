//
//  Barista.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct Barista: Identifiable, Codable {
    var id = UUID()
    let name: String
    var isActive: Bool = false
    var isTopBarista: Bool = false
    let image: String
}
