//
//  Level.swift
//  VocabularyApp
//
//  Created by Yıldız Aydın on 9.07.2025.
//

import Foundation

struct Level: Identifiable, Codable {
    let id = UUID()
    let levelNumber: Int
    let words: [Word] // bu seviyeye ait kelimeler
    
    
    init(levelNumber: Int, words: [Word]) {
        self.levelNumber = levelNumber
        self.words = words
    }
    
    //moc data
    
    static func exampleLevels() -> [Level] {
           [
               Level(levelNumber: 1, words: [
                   Word(english: "Hello", turkish: "Merhaba", exampleSentence: "Hello, how are you?"),
                   Word(english: "World", turkish: "Dünya", exampleSentence: "The world is big."),
                   Word(english: "Apple", turkish: "Elma", exampleSentence: "I like to eat an apple."),
                   Word(english: "Book", turkish: "Kitap", exampleSentence: "She is reading a book."),
                   Word(english: "Water", turkish: "Su", exampleSentence: "Please give me some water."),
                   Word(english: "Sun", turkish: "Güneş", exampleSentence: "The sun is shining."),
                   Word(english: "Moon", turkish: "Ay", exampleSentence: "The moon is bright tonight."),
                   Word(english: "Tree", turkish: "Ağaç", exampleSentence: "A bird is on the tree."),
                   Word(english: "House", turkish: "Ev", exampleSentence: "My house is cozy."),
                   Word(english: "Car", turkish: "Araba", exampleSentence: "He bought a new car.")
               ]),
               Level(levelNumber: 2, words: [
                   Word(english: "Computer", turkish: "Bilgisayar", exampleSentence: "I work on my computer."),
                   Word(english: "Phone", turkish: "Telefon", exampleSentence: "My phone is ringing."),
                   Word(english: "Friend", turkish: "Arkadaş", exampleSentence: "She is my best friend."),
                   Word(english: "Family", turkish: "Aile", exampleSentence: "Family is important."),
                   Word(english: "Travel", turkish: "Seyahat etmek", exampleSentence: "I love to travel."),
                   Word(english: "Food", turkish: "Yemek", exampleSentence: "This food is delicious."),
                   Word(english: "Music", turkish: "Müzik", exampleSentence: "I enjoy listening to music."),
                   Word(english: "Sport", turkish: "Spor", exampleSentence: "My favorite sport is swimming."),
                   Word(english: "Happy", turkish: "Mutlu", exampleSentence: "She looks very happy."),
                   Word(english: "Sad", turkish: "Üzgün", exampleSentence: "He felt sad after the news.")
               ])
               
           ]
       }
   }
    

