import SwiftUI

struct WordCardStackView: View {
    let words: [Word]
    let currentIndex: Int
    let categoryColor: Color
    let dragOffset: CGSize
    let onFavoriteToggle: (Word) -> Void
    
    var body: some View {
        ZStack {
            ForEach(0..<min(3, words.count), id: \.self) { index in
                cardView(for: index)
            }
        }
    }
    @ViewBuilder
    private func cardView(for index: Int) -> some View {
        let cardIndex = (currentIndex + index) % words.count

        if cardIndex < words.count {
            let word = words[cardIndex]

            WordFlashCard(
                word: word,
                categoryColor: categoryColor,
                onFavoriteToggle: onFavoriteToggle
            )
            .scaleEffect(index == 0 ? 1.0 : 0.95 - Double(index) * 0.05)
            .offset(y: Double(index) * 8)
            .zIndex(Double(3 - index))
            .offset(index == 0 ? dragOffset : .zero)
            .rotationEffect(.degrees(index == 0 ? Double(dragOffset.width) / 20 : 0))
            .opacity(index == 0 ? (1.0 - Double(abs(dragOffset.width)) / 300.0) : 1.0)
        } else {
            EmptyView()
        }
    }

    
}
    #Preview {
        WordCardStackView(
            words: Word.sampleWords,
            currentIndex: 0,
            categoryColor: .pink,
            dragOffset: .zero,
            onFavoriteToggle: { _ in }
        )
    }
    

