//
//  RewardModel.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation

struct Reward: Identifiable {
    let id = UUID()
    let name: String
    let date: String
    let points: String
}
