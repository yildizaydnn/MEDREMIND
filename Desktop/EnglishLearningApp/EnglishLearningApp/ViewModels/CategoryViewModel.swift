//
//  CategoryViewModel.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import Foundation
import SwiftUI


class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    
  
    init() {
        loadCategories()
    }
    
    private func loadCategories() {
        //şimdilik sabit datalar sonra core datadan çekicez
        
        categories = [
            Category(
                name: "Shopping",
                imageName: "shoping",
                color: Color.pink,
                wordCount: 25
            ),
            Category(
                name: "Sport",
                imageName: "sport",
                color: Color.purple,
                wordCount: 18
            ),
            Category(
                name: "Food",
                imageName: "food",
                color: Color.orange,
                wordCount: 30
            ),
            Category(
                name: "Travel",
                imageName: "travel",
                color: Color.green,
                wordCount: 28
            ),
            Category(
                name: "Animals",
                imageName: "animals",
                color: Color.green,
                wordCount: 30
               ),
            Category(
                name: "Jobs",
                imageName: "jobs",
                color: Color.black,
                wordCount: 30
                ),
            
            Category(
                name: "Emotions",
                imageName: "emotions",
                color: Color.yellow,
                wordCount: 30
                )
                
            ]
            
        
    }
}
