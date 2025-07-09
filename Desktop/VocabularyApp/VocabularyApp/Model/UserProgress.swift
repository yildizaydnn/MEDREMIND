//
//  UserProgress.swift
//  VocabularyApp
//
//  Created by Yıldız Aydın on 9.07.2025.
//

import Foundation

struct UserProgress: Codable {
    var currentLevel: Int = 1
    var completedDays: Int = 0
    var saveWords: [Word] = []
    
  
}
