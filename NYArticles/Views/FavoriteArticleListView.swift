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
                        Label("No liked articles", systemImage: "star.slash")
                    }, description: {
                        Text("Add liked articles to check them later!")
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
            .onChange(of: favoriteArticles, { _, _ in
                if favoriteArticles.isEmpty {
                    showContentUnavailable = true
                } else {
                    showContentUnavailable = false
                }
            })
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
