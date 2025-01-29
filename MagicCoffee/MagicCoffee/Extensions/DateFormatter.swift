//
//  DateFormatter.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 24.01.25.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, h:mm a" 
        return formatter.string(from: self)
    }

    func formatToDay(isOngoing: Bool) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        let formattedDate = formatter.string(from: self)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let formattedTime = timeFormatter.string(from: self)
        
        if isOngoing {
            return "\(formattedDate) | By \(formattedTime)"
        } else {
            return "\(formattedDate) | At \(formattedTime)"
        }
    }
}
