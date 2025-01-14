//
//  Barista.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct Barista: Identifiable {
    let id = UUID()
    let name: String
    let isActive: Bool = false
    let isTopBarista: Bool = false
    let image: String
}
