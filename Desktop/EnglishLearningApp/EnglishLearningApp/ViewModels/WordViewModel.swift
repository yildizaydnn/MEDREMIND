//
//  WordViewModel.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//
import Foundation
import SwiftUI

class WordViewModel: ObservableObject {
    static let shared = WordViewModel()
    
    @Published var words: [Word] = []
    @Published var favoriteWords: [Word] = []
    
    init() {
        loadWords()
        updateFavoriteWords()
    }
    
    func loadWords() {
        // Şimdilik örnek veriler - daha sonra Core Data'dan çekeceğiz
        words = [
            // Shopping kelimeleri
            Word(english: "Shopping", turkish: "Alışveriş", category: "Shopping"),
            Word(english: "Store", turkish: "Mağaza", category: "Shopping"),
            Word(english: "Buy", turkish: "Satın almak", category: "Shopping"),
            Word(english: "Price", turkish: "Fiyat", category: "Shopping"),
            Word(english: "Discount", turkish: "İndirim", category: "Shopping"),
            Word(english: "Receipt", turkish: "Fiş", category: "Shopping"),
            Word(english: "Cashier", turkish: "Kasiyer", category: "Shopping"),
            Word(english: "Shopping cart", turkish: "Alışveriş arabası", category: "Shopping"),
            
            // Sport kelimeleri
            Word(english: "Football", turkish: "Futbol", category: "Sport"),
            Word(english: "Basketball", turkish: "Basketbol", category: "Sport"),
            Word(english: "Tennis", turkish: "Tenis", category: "Sport"),
            Word(english: "Swimming", turkish: "Yüzme", category: "Sport"),
            Word(english: "Running", turkish: "Koşu", category: "Sport"),
            Word(english: "Gym", turkish: "Spor salonu", category: "Sport"),
            
            // Music kelimeleri
            Word(english: "Song", turkish: "Şarkı", category: "Music"),
            Word(english: "Guitar", turkish: "Gitar", category: "Music"),
            Word(english: "Piano", turkish: "Piyano", category: "Music"),
            Word(english: "Melody", turkish: "Melodi", category: "Music"),
            Word(english: "Concert", turkish: "Konser", category: "Music"),
            
            // Food kelimeleri
            Word(english: "Apple", turkish: "Elma", category: "Food"),
            Word(english: "Bread", turkish: "Ekmek", category: "Food"),
            Word(english: "Water", turkish: "Su", category: "Food"),
            Word(english: "Restaurant", turkish: "Restoran", category: "Food"),
            Word(english: "Delicious", turkish: "Lezzetli", category: "Food"),
            
            // Travel kelimeleri
            Word(english: "Airport", turkish: "Havaalanı", category: "Travel"),
            Word(english: "Hotel", turkish: "Otel", category: "Travel"),
            Word(english: "Passport", turkish: "Pasaport", category: "Travel"),
            Word(english: "Suitcase", turkish: "Bavul", category: "Travel"),
            Word(english: "Vacation", turkish: "Tatil", category: "Travel")
        ]
    }
    
    func wordsForCategory(_ categoryName: String) -> [Word] {
        return words.filter { $0.category == categoryName }
    }
    
    func favoriteWordsForCategory(_ categoryName: String) -> [Word] {
        return words.filter { $0.category == categoryName && $0.isFavorite }
    }
    
    func toggleFavorite(word: Word) {
        if let index = words.firstIndex(where: { $0.id == word.id }) {
            words[index].isFavorite.toggle()
            print("Kelime favorilendi: \(word.english) - \(words[index].isFavorite)")

            updateFavoriteWords()
        }
    }
    
    private func updateFavoriteWords() {
        favoriteWords = words.filter { $0.isFavorite }
          print("Favori kelimeler güncellendi: \(favoriteWords.count) adet")    }
}
