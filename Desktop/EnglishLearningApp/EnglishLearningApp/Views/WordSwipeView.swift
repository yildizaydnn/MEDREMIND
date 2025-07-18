import SwiftUI

struct WordSwipeView: View {
    let category: Category
    @StateObject private var viewModel = WordViewModel()
    @Environment(\.dismiss) private var dismiss

    @State private var currentIndex = 0
    @State private var dragOffset = CGSize.zero
    @State private var isAnimating = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Üst başlık
                WordSwipeHeaderView(
                    categoryName: category.name,
                    currentIndex: currentIndex,
                    totalCount: wordsForCategory.count,
                    onDismiss: { dismiss() },
                    onRestart: {
                        currentIndex = 0
                        dragOffset = .zero
                    }
                )

                // Progress bar
                WordSwipeProgressView(
                    currentIndex: currentIndex,
                    totalCount: wordsForCategory.count,
                    color: category.color
                )

                // Kart alanı
                WordCardStackView(
                    words: wordsForCategory,
                    currentIndex: currentIndex,
                    categoryColor: category.color,
                    dragOffset: dragOffset,
                    onFavoriteToggle: { word in
                        viewModel.toggleFavorite(word: word)
                    }
                )
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if !isAnimating {
                                dragOffset = value.translation
                            }
                        }
                        .onEnded { value in
                            handleSwipe(value: value)
                        }
                )
                .padding(.horizontal, 20)
                .padding(.vertical, 40)

                // Alt kontroller
                WordSwipeControlsView(
                    currentIndex: currentIndex,
                    totalCount: wordsForCategory.count,
                    isFavorite: currentWord?.isFavorite == true,
                    onPrevious: goToPrevious,
                    onNext: goToNext,
                    onToggleFavorite: {
                        if let word = currentWord {
                            viewModel.toggleFavorite(word: word)
                        }
                    }
                )
            }
            .navigationBarHidden(true)
            .background(Color(.systemGroupedBackground))
        }
        .onAppear {
            viewModel.loadWords()
        }
    }

    // Computed Properties
    private var wordsForCategory: [Word] {
        viewModel.wordsForCategory(category.name)
    }

    private var currentWord: Word? {
        guard currentIndex < wordsForCategory.count else { return nil }
        return wordsForCategory[currentIndex]
    }

    // Swipe logic
    private func handleSwipe(value: DragGesture.Value) {
        let swipeThreshold: CGFloat = 100

        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            if value.translation.width > swipeThreshold {
                goToPrevious()
            } else if value.translation.width < -swipeThreshold {
                goToNext()
            }

            dragOffset = .zero
        }
    }

    private func goToNext() {
        guard currentIndex < wordsForCategory.count - 1 else { return }

        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            currentIndex += 1
            dragOffset = .zero
        }
    }

    private func goToPrevious() {
        guard currentIndex > 0 else { return }

        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            currentIndex -= 1
            dragOffset = .zero
        }
    }
}

#Preview {
    WordSwipeView(
        category: Category(
            name: "Shopping",
            imageName: "shopping-category",
            color: Color.pink,
            wordCount: 25
        )
    )
}

