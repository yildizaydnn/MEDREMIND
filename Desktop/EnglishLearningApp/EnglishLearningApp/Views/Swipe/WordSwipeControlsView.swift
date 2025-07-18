//
//  WordSwipeControlsView.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import SwiftUI

struct WordSwipeControlsView: View {
    let currentIndex: Int
    let totalCount: Int
    let isFavorite: Bool
    let onPrevious: () -> Void
    let onNext: () -> Void
    let onToggleFavorite: () -> Void

    var body: some View {
        HStack(spacing: 40) {
            Button(action: onPrevious) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
                    .background(Color(.systemBackground))
                    .cornerRadius(25)
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
            }
            .disabled(currentIndex == 0)

            Button(action: onToggleFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.title)
                    .foregroundColor(isFavorite ? .red : .gray)
                    .frame(width: 60, height: 60)
                    .background(Color(.systemBackground))
                    .cornerRadius(30)
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
            }

            Button(action: onNext) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
                    .background(Color(.systemBackground))
                    .cornerRadius(25)
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
            }
            .disabled(currentIndex >= totalCount - 1)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
    }
}


#Preview {
    WordSwipeControlsView(
        currentIndex: 1,
        totalCount: 5,
        isFavorite: true,
        onPrevious: {},
        onNext: {},
        onToggleFavorite: {}
    )
}
