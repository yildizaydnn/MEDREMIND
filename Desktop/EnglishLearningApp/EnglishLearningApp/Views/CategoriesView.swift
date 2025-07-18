//
//  CategoriesView.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject private var viewModel = CategoryViewModel()
    @ObservedObject private var wordViewModel = WordViewModel.shared
    @State private var selectedCategory: Category? = nil
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Kategorini seç")
                                                    .font(.largeTitle)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.orange)
                        
                                               Text("İngilizceni geliştir!")
                                                   .font(.largeTitle)
                                                   .fontWeight(.bold)
                                                   .foregroundColor(.pink)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal)
                                        .padding(.top, 20)
                    
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.categories) { category in
                            CategoryCard(category: category)
                                .onTapGesture {
                                    selectedCategory = category
                                }
                        }
                    }
                    .padding()
                    
                    Spacer(minLength: 100)
                                        
                }
            }
            .navigationBarHidden(true)
            .background(Color(.systemBackground))
        }
        .sheet(item: $selectedCategory) { category in
            WordSwipeView(category: category)
        }
    }
}

#Preview {
    CategoriesView()
}
