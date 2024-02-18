//
//  FavoriteArticleListView.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import SwiftUI
import SwiftData

struct FavoriteArticleListView: View {

    @Environment(\.modelContext) private var modelContext
    @Query (sort: \ArticleModelData.updatedDate, order: .reverse)private var favoriteArticles: [ArticleModelData]

    @State var showContentUnavailable = false

    var body: some View {
        NavigationStack {
            VStack {
                if showContentUnavailable {
                    ContentUnavailableView(label: {
                        Label("No favorites articles", systemImage: "star.slash")
                    }, description: {
                        Text("Add favorites articles to check them later even without conection!")
                    }, actions: {
                    })
                } else {
                    List {
                        ForEach(favoriteArticles) { article in
                            NavigationLink {
                                WebView(url: URL(string: article.url)!)
                            } label: {
                                ArticleCellView(articleModel: article)
                            }

                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Liked Articles")
            .onAppear(perform: {
                showContentUnavailable = favoriteArticles.isEmpty
            })
        }
    }
}

#Preview {
    FavoriteArticleListView()
}
