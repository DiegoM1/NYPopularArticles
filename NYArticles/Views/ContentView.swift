//
//  ContentView.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        TabView {
            ArticleListView()
                .tabItem { Label("Articles", systemImage: "book.pages.fill") }
            FavoriteArticleListView()
                .tabItem { Label("Favorite Articles", systemImage: "books.vertical") }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ArticleModelData.self, inMemory: true)
}
