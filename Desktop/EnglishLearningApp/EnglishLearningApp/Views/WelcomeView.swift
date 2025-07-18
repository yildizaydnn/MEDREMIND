//
//  WelcomeView.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showMainApp = false
    
    var body: some View {
        ZStack {
            
            Image("welcome")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .ignoresSafeArea()
            
            
           Color.black.opacity(0.3)
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                Spacer()
                
                // Welcome text
                VStack(spacing: 12) {
                    Text("Hoşgeldin!")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("İngilizce Öğrenmeye Başla")
                        .font(.system(size: 24, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.bottom, 60)
                
                // Start button
                Button(action: {
                    showMainApp = true
                }) {
                    Text("Başla")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(red: 0.2, green: 0.25, blue: 0.35))
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.white)
                        .cornerRadius(28)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
        }
        .fullScreenCover(isPresented: $showMainApp) {
            CategoriesView()
        }
    }
}

#Preview {
    WelcomeView()
}
