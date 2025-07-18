//
//  EnglishLearningAppApp.swift
//  EnglishLearningApp
//
//  Created by Yıldız Aydın on 18.07.2025.
//

import SwiftUI

@main
struct EnglishLearningAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
