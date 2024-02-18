//
//  ArticleListView.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import SwiftUI
import SwiftData

struct ArticleListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteArticles: [ArticleModelData]

    @State var articleService: ArticleServicesProtocol
    @State var articles: [ArticleModel] = .init()
    @State var pathType: PathsType = .shared
    @State var period: Period = .day
    @State var showContentUnavailable = false
    @State var isLoading = true

    init(articleService: ArticleServicesProtocol = ArticleServices()) {
        _articleService = State(initialValue: articleService)
    }


    func fetchArticles() async {
        do {
            isLoading = true
            let articles = try await articleService.getArticlesBy(pathType: pathType, andPeriod: period)
            self.articles = articles.results
            self.showContentUnavailable = false
            isLoading = false
        } catch {
            isLoading = false
            self.showContentUnavailable = true
            print(error)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack{
                if isLoading {
                    ProgressView()
                        .controlSize(.extraLarge)
                        .progressViewStyle(.circular)
                        .zIndex(1)
                } else {

                        VStack(alignment: .center) {
                            if showContentUnavailable {
                                ContentUnavailableView(label: {
                                    Label("No Articles", systemImage: "exclamationmark.warninglight")
                                }, description: {
                                    Text("Check your internet connection and try again, meanwhile you can check your favorites articles")
                                }, actions: {
                                    Button(action: {
                                        Task {
                                            await fetchArticles()
                                        }
                                    }) {
                                        Text("Try Again")
                                    }
                                })
                            } else {
                                ScrollView {
                                    LazyVStack(alignment: .leading) {
                                        ForEach(articles) { article in
                                            NavigationLink {
                                                WebView(url: URL(string: article.url)!)
                                            } label: {
                                                ArticleCellView(articleModel: article)
                                            }
                                            Divider()
                                        }
                                    }
                                    .padding(20)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                                    .foregroundStyle(.black)
                                    .padding()
                                }
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Menu {
                                    ForEach(Period.allCases) { period in
                                        Button {
                                            self.period = period
                                        } label: {
                                            Label(period.title(), systemImage: self.period == period ? "checkmark" : "calendar")
                                        }
                                    }
                                } label: {
                                    Image(systemName: "calendar")
                                }
                            }

                            ToolbarItem {
                                Menu {
                                    ForEach(PathsType.allCases) { path in
                                        Button {
                                            self.pathType = path
                                        } label: {
                                            Label(path.title(), systemImage: self.pathType == path ? "checkmark" : "shared.with.you")
                                        }
                                    }
                                } label: {
                                    Image(systemName: "shared.with.you")
                                }
                            }
                        }
                        .background(Color("Background"))
                }
            }
            .onChange(of: pathType) { oldValue, newValue in
                Task {
                    await fetchArticles()
                }
            }
            .onChange(of: period) { oldValue, newValue in
                Task {
                    await fetchArticles()
                }
            }

            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Popular Articles")
            .task {
                await fetchArticles()
            }
        }
    }
}

#Preview {
    ArticleListView(articleService: MockArticleServices())
}
