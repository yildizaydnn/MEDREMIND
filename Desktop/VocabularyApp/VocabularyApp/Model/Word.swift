//
//  Word.swift
//  VocabularyApp
//
//  Created by Yıldız Aydın on 9.07.2025.
//

import Foundation

struct Word: Identifiable, Codable {
    let id = UUID()
    let english: String
    let turkish: String
    let exampleSentence: String? // isteğimize bağlı olabilir
    
    init(english: String, turkish: String, exampleSentence: String? = nil) {
        self.english = english
        self.turkish = turkish
        self.exampleSentence = exampleSentence
    }
    
}
