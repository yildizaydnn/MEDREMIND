//
//  CategoryCard.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//
//
//  CategoryCard.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import SwiftUI

struct CategoryCard: View {
    let category: Category
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(category.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .cornerRadius(12)
            
            Spacer()
            
            Text(category.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            Text("\(category.wordCount) words")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))

        }
        
        .padding(16)
        .frame(width: 140, height: 200)
        .background(category.color)
        .cornerRadius(20)
        .shadow(color: category.color.opacity(0.3), radius: 8, x:0, y:4)
    }
}

#Preview {
    CategoryCard(category: Category(
        name: "Shopping", imageName: "shoping", color: Color.pink, wordCount: 25
    ) )
}

