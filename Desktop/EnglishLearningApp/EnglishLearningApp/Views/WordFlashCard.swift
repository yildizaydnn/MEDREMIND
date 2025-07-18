//
//  WordFlashCard.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import SwiftUI

struct WordFlashCard: View {
    let word: Word
    let categoryColor: Color
    let onFavoriteToggle: (Word) -> Void
    
    @State private var isFlipped = false
    
    var body: some View {
        ZStack {
            // Arka yüz (Türkçe)
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [categoryColor, categoryColor.opacity(0.7)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    VStack(spacing: 20) {
                        Text("🔄")
                            .font(.system(size: 40))
                        
                        Text(word.turkish)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Text("Turkish")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                            .fontWeight(.medium)
                    }
                )
                .opacity(isFlipped ? 1 : 0)
                .scaleEffect(isFlipped ? 1 : 0.9)
            
            // Ön yüz (İngilizce)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .overlay(
                    VStack(spacing: 20) {
                        Text("🇬🇧")
                            .font(.system(size: 40))
                        
                        Text(word.english)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        Text("English")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .fontWeight(.medium)
                    }
                )
                .opacity(isFlipped ? 0 : 1)
                .scaleEffect(isFlipped ? 0.9 : 1)
        }
        .frame(height: 300)
        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                isFlipped.toggle()
            }
        }
    }
}

#Preview {
    WordFlashCard(
        word: Word(english: "Shopping", turkish: "Alışveriş", category: "Shopping"),
        categoryColor: .pink,
        onFavoriteToggle: { _ in }
    )
    .padding()
}
