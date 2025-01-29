//
//  Coffee.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation


struct Coffee: Identifiable, Codable, Hashable {
    var id = UUID()
    var count = 1
    var name: String
    var ristreto = 1
    var size: CoffeeSize = .small
    var image = ""
    var sortByOrigin = ""
    var grinding: GrindingLevel = .fine
    var milk = ""
    var syrup = ""
    var iceAmount = 0
    var roastingLevel: RoastingLevel = .medium
    var additives = [""]
    var score = 0
    var redeemPointsAmount = 0
    var validityDate = ""
    var price = 0.0
    var orderDate = Date.now
    var prepTime = Date.now
    
    
    enum CoffeeSize: String, Codable {
        case small, medium, large
        
        init?(intValue: Int) {
            switch intValue {
            case 1:
                self = .small
            case 2:
                self = .medium
            case 3:
                self = .large
            default:
                return nil 
            }
        }
    }
    
    enum RoastingLevel: String, Codable {
        case low, medium, high
        
        init?(_ intValue: Int) {
            switch intValue {
            case 1:
                self = .low
            case 2:
                self = .medium
            case 3:
                self = .high
            default:
                return nil
            }
        }
    }

    enum GrindingLevel: String ,Codable {
        case fine, medium
        
        init?(intValue: Int) {
            switch intValue {
            case 0:
                self = .fine
            case 1:
                self = .medium
            default:
                return nil
            }
        }
    }
    
    static let example = Coffee(count: 2, name: "", ristreto: 1, size: CoffeeSize.large, image: "Latte", sortByOrigin: "sd", grinding: GrindingLevel.fine, milk: "", syrup: "", iceAmount: 1, roastingLevel: RoastingLevel.low, additives: [""], score: 1, redeemPointsAmount: 200, validityDate: "", price: 6, orderDate: Date())
}

extension Coffee {
    func asDictionary() -> [String: Any] {
        return [
            "count": count,
            "name": name,
            "ristretto": ristreto,
            "size": size.rawValue,
            "image": image,
            "sortByOrigin": sortByOrigin,
            "grinding": grinding.rawValue,
            "milk": milk,
            "syrup": syrup,
            "iceAmount": iceAmount,
            "roastingLevel": roastingLevel.rawValue,
            "additives": additives,
            "score": score,
            "redeemPointsAmount": redeemPointsAmount,
            "price": price,
            "orderDate": orderDate,
            "prepTime": prepTime
        ]
    }
}

