//
//  WordSwipeProgressView.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import SwiftUI

struct WordSwipeProgressView: View {
    let currentIndex: Int
    let totalCount: Int
    let color: Color

    var body: some View {
        ProgressView(value: Double(currentIndex), total: Double(max(totalCount - 1, 1)))
            .progressViewStyle(LinearProgressViewStyle(tint: color))
            .padding(.horizontal, 20)
            .padding(.top, 10)
    }
}


#Preview {
    WordSwipeProgressView(
        currentIndex: 2,
        totalCount: 10,
        color: .pink
    )
}
