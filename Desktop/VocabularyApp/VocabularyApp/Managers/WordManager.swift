//
//  WordManager.swift
//  VocabularyApp
//
//  Created by Yıldız Aydın on 9.07.2025.
//

import Foundation
import Combine

class WordManager: ObservableObject {
    @Published private(set) var allLevels: [Level]
    @Published private(set) var currentWordsForLearning: [Word] = []
    
    init() {
        self.allLevels = Level.exampleLevels()
       
    }
    
    func updateCurrentWordsForLearning(forLevel levelNumber: Int) {
        guard let level = allLevels.first(where: { $0.levelNumber == levelNumber }) else {
            print("Hata: Seviye (\(levelNumber)) bulunamadı")
            currentWordsForLearning = []
            return
        }
        
        //günlük 10 kelime kuralını uyguluyoruz
        
        currentWordsForLearning = Array(level.words.prefix(10))
        print("Seviye \(levelNumber) için \(currentWordsForLearning.count) kelime yüklendi")
    }
    
    func words(forLevel levelNumber: Int) -> [Word] {
        return allLevels.first(where: { $0.levelNumber == levelNumber })?.words ?? []
    }
}
