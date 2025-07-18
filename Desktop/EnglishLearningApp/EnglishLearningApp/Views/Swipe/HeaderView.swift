//
//  HeaderView.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//
import SwiftUI

struct WordSwipeHeaderView: View {
    let categoryName: String
    let currentIndex: Int
    let totalCount: Int
    let onDismiss: () -> Void
    let onRestart: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                onDismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack {
                Text(categoryName)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("\(currentIndex + 1) / \(totalCount)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                onRestart()
            }) {
                Image(systemName: "arrow.clockwise")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}


#Preview {
    WordSwipeHeaderView(
        categoryName: "Shopping",
        currentIndex: 2,
        totalCount: 10,
        onDismiss: {},
        onRestart: {}
    )
}
