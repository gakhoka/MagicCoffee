//
//  StringExtension.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.02.25.
//


extension String {
    func formattedExpirationDate() -> String {
        let digits = self.filter { $0.isNumber }
        let limitedDigits = String(digits.prefix(4))
        
        var formattedDate = ""
        for (index, char) in limitedDigits.enumerated() {
            if index == 2 {
                formattedDate.append("/")
            }
            formattedDate.append(char)
        }
        
        return formattedDate
    }
    
    func formattedCardNumber() -> String {
        let digits = self.filter { $0.isNumber }
        let limitedDigits = String(digits.prefix(16))
        
        var formattedNumber = ""
        for (index, char) in limitedDigits.enumerated() {
            if index > 0 && index % 4 == 0 {
                formattedNumber.append(" ")
            }
            formattedNumber.append(char)
        }
        
        return formattedNumber
    }
}
