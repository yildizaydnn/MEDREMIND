//
//  SettingsView.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

//
//  SettingsView.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @State private var isDarkMode = false
    @State private var showAboutSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Ayarlar")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("Uygulama tercihlerinizi yönetin")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Settings List
                List {
                    Section("Görünüm") {
                        HStack {
                            Image(systemName: "moon.fill")
                                .foregroundColor(.purple)
                                .frame(width: 24, height: 24)
                            
                            Text("Koyu Tema")
                                .font(.body)
                            
                            Spacer()
                            
                            Toggle("", isOn: $isDarkMode)
                                .labelsHidden()
                        }
                        .padding(.vertical, 4)
                    }
                    
                    Section("Hakkında") {
                        // Uygulama Hakkında
                        Button(action: {
                            showAboutSheet = true
                        }) {
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .foregroundColor(.blue)
                                    .frame(width: 24, height: 24)
                                
                                Text("Uygulama Hakkında")
                                    .font(.body)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                        
                        // Uygulamayı Değerlendir
                        Button(action: {
                            rateApp()
                        }) {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .frame(width: 24, height: 24)
                                
                                Text("Uygulamayı Değerlendir")
                                    .font(.body)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Image(systemName: "arrow.up.right")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .padding(.top, 20)
                
                Spacer()
            }
            .navigationBarHidden(true)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .sheet(isPresented: $showAboutSheet) {
            AboutView()
        }
    }
    
    private func rateApp() {
        // App Store değerlendirme sayfasını açma
        if let url = URL(string: "https://apps.apple.com/app/id123456789") {
            UIApplication.shared.open(url)
        }
    }
}

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // App Icon
                Image(systemName: "book.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.pink)
                    .padding(.top, 40)
                
                // App Info
                VStack(spacing: 12) {
                    Text("English Learning App")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Versiyon 1.0.0")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Description
                VStack(spacing: 16) {
                    Text("İngilizce kelime öğrenme uygulaması")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    Text("Bu uygulama, İngilizce kelime dağarcığınızı artırmanıza yardımcı olur. Farklı kategorilerdeki kelimeleri öğrenin, favorilerinizi seçin ve ilerlemenizi takip edin.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                // Credits
                VStack(spacing: 8) {
                    Text("Geliştiren")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("Yıldız Aydın")
                        .font(.headline)
                        .foregroundColor(.pink)
                }
                .padding(.bottom, 40)
            }
            .navigationTitle("Hakkında")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kapat") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
