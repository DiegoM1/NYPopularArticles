//
//  NYArticlesApp.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import SwiftUI
import SwiftData

@main
struct NYArticlesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ArticleModelData.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
