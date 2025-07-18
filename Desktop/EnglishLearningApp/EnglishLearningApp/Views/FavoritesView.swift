//
//  FavoritesView.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject private var wordViewModel = WordViewModel.shared
    @State private var searchText = ""
    
    var filteredFavorites: [Word] {
        if searchText.isEmpty {
            return wordViewModel.favoriteWords
        } else {
            return wordViewModel.favoriteWords.filter { word in
                word.english.lowercased().contains(searchText.lowercased()) ||
                word.turkish.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Favori Kelimelerim")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("\(wordViewModel.favoriteWords.count) kelime")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Kelime ara...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Favorites List
                if filteredFavorites.isEmpty {
                    EmptyFavoritesView(hasSearchText: !searchText.isEmpty)
                } else {
                    List {
                        ForEach(filteredFavorites) { word in
                            FavoriteWordCard(word: word) {
                                wordViewModel.toggleFavorite(word: word)
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .padding(.top, 16)
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
            .onAppear {
                wordViewModel.loadWords()
            }
        }
    }
}

struct FavoriteWordCard: View {
    let word: Word
    let onToggleFavorite: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Category Badge
            Text(word.category)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(categoryColor(for: word.category))
                .cornerRadius(12)
            
            // Word Content
            VStack(alignment: .leading, spacing: 4) {
                Text(word.english)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Text(word.turkish)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Favorite Button
            Button(action: onToggleFavorite) {
                Image(systemName: word.isFavorite ? "heart.fill" : "heart")
                    .font(.title2)
                    .foregroundColor(word.isFavorite ? .red : .gray)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
    
    private func categoryColor(for category: String) -> Color {
        switch category {
        case "Shopping": return .pink
        case "Sport": return .purple
        case "Food": return .orange
        case "Travel": return .green
        case "Animals": return .blue
        case "Jobs": return .black
        case "Emotions": return .yellow
        default: return .gray
        }
    }
}

struct EmptyFavoritesView: View {
    let hasSearchText: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // Icon
            Image(systemName: hasSearchText ? "magnifyingglass" : "heart.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.5))
            
            // Message
            VStack(spacing: 8) {
                Text(hasSearchText ? "Sonuç bulunamadı" : "Henüz favori kelime yok")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                Text(hasSearchText ?
                     "Arama kriterinize uygun kelime bulunamadı" :
                     "Kelime kartlarındaki kalp ikonuna tıklayarak favori kelimelerinizi ekleyebilirsiniz")
                    .font(.subheadline)
                    .foregroundColor(.gray.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
        }
    }
}

#Preview {
    FavoritesView()
}
