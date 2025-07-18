//
//  Word.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import Foundation

struct Word: Identifiable, Codable {
    
    let id = UUID()
    let english: String
    let turkish: String
    let category: String
    var isFavorite: Bool = false
    
    
    init(english: String, turkish: String, category: String) {
        self.english = english
        self.turkish = turkish
        self.category = category
        
    }
}

extension Word {
    static let sampleWords: [Word] = [
        Word(english: "Shopping", turkish: "Alışveriş", category: "Shopping"),
        Word(english: "Store", turkish: "Mağaza", category: "Shopping"),
        Word(english: "Buy", turkish: "Satın almak", category: "Shopping"),
        Word(english: "Price", turkish: "Fiyat", category: "Shopping"),
        Word(english: "Discount", turkish: "İndirim", category: "Shopping")
    ]
}
