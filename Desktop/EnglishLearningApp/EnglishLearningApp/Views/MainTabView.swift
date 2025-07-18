//
//  MainTabView.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//
//
//  MainTabView.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Ana Sayfa - Kategoriler
            CategoriesView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Ana Sayfa")
                }
                .tag(0)
            
            // Favoriler
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favoriler")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Ayarlar")

                }
                .tag(2)
            
            
          
        }
        .accentColor(.pink) // Tab bar seçili rengi
    }
}




#Preview {
    MainTabView()
}
