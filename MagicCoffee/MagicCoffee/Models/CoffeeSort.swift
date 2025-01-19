//
//  CoffeeSort.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 14.01.25.
//

import Foundation

struct Country: Identifiable, Codable {
    var id = UUID()
    let name: String
    let cities: [City]
    
    struct City: Identifiable, Codable {
        var id = UUID()
        let name: String
    }
}

struct QuizQuestion: Identifiable, Codable {
    var id = UUID()
    
    let question: String
    let difficulty: String
    let category: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case question
        case difficulty
        case category
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}


