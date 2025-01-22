//
//  ArticleCellView.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import SwiftUI
import SwiftData

struct ArticleCellView: View {

    @Environment(\.modelContext) private var modelContext

    var articleModel: ModelDataProtocol
    @Query var favoriteArticles: [ArticleModelData]
    var isFavorite: Bool {
        !favoriteArticles.filter { $0.id == articleModel.id }.isEmpty
    }

    @State var seeMore = false


    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(articleModel.updatedTime?.beautifulDateFormat() ?? "")
                            .font(.caption)
                        Image(systemName: isFavorite ? "star.fill" : "star")
                            .foregroundStyle(.yellow)
                            .onTapGesture {
                                if isFavorite {
                                    withAnimation {
                                        deleteItem(article: articleModel)
                                    }
                                } else {
                                    withAnimation {
                                        addItem(article: articleModel)
                                    }
                                }
                            }
                    }
                    Text(articleModel.title)
                        .multilineTextAlignment(.leading)
                        .font(.title3).fontWeight(.bold)
                        .padding(.bottom, 2)
                    Text(articleModel.byline)
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                        .padding(.bottom, 8)

                    Text(articleModel.section.rawValue)
                        .foregroundStyle(articleModel.section.getColor())
                        .font(.footnote).fontWeight(.medium)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(articleModel.section.getColor().opacity(0.2)))
                }
                Spacer()
                if let url = articleModel.media.first?.mediaMetadata.filter({ $0.format == .big }).first?.realUrl {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "questionmark.app")
                    }
                    .frame(width: 120, height: 120)
                    .cornerRadius(10)
                }
            }
            if seeMore {
                Text(articleModel.abstract)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .padding(.bottom, 4)

                Text("Keywords")
                    .font(.footnote).fontWeight(.bold)
                    .underline(true)
                    .padding(.bottom, 4)
                Text(articleModel.adxKeywords)
                    .multilineTextAlignment(.leading)
                    .font(.footnote).fontWeight(.light)
                    .padding(.bottom, 4)

                Text("Published date \(articleModel.publishedDate.toDate(withFormat: "yyyy-MM-dd")?.toString(withFormat: "MMM d, yyyy") ?? "")")
                    .font(.subheadline).fontWeight(.semibold)
            }

            HStack(alignment: .center) {
                Spacer()
                Image(systemName: seeMore ? "chevron.up" : "chevron.down")
                    .imageScale(.small
                    )
                Spacer()
            }
            .padding(.bottom, 8)
            .onTapGesture(perform: {
                withAnimation {
                    seeMore.toggle()
                }

            })
            .foregroundStyle(.blue)
            .contentTransition(.symbolEffect(.replace))

            .padding(.top, 4)
        }
    }

    func addItem(article: ModelDataProtocol) {
        let modelData = ArticleModelData(url: article.url,
                                         id: article.id,
                                         publishedDate: article.publishedDate,
                                         updated: article.updatedTime ?? "",
                                         section: article.section,
                                         byline: article.byline,
                                         title: article.title,
                                         abstract: article.abstract,
                                         adxKeywords: article.adxKeywords,
                                         media: article.media)
        modelContext.insert(modelData)
    }

    func deleteItem(article: ModelDataProtocol) {
        guard let modelData = favoriteArticles.filter({ $0.id == article.id }).first else {
            return
        }
        modelContext.delete(modelData)

    }
}

#Preview {
    ArticleCellView(articleModel: ArticleModel(url: "https://www.google.com",
                                               id: 10000000000,
                                               publishedDate: "2024-02-11",
                                               updated: "2024-02-13 11:35:55",
                                               section: .arts,
                                               byline: "By Mike Hale",
                                               title: "The super Bowl ads, Ranked", adxKeywords: "Actors and Actresses, photography;Cooper, Bradly;Ruffalo, Mark;Randolph",
                                               abstract: "Here is how our critic saw the Super Bowl commercials from the best to worst.", media: [ArticleMediaModel(type: "Image",
                                                                                                                                                                    subtype: "photo",
                                                                                                                                                                    caption: "Christopher Walken stars in a BMW ad that pokes fun at people's tendency to impersonate",
                                                                                                                                                                    copyright: "BMW", mediaMetadata: [MediaMetadata(url: "https://static01.nyt.com/images/2024/02/15/multimedia/14blow1-gfqt/14blow1-gfqt-thumbStandard.jpg", format: .small,
                                                                                                                                                                                                                    height: 75,
                                                                                                                                                                                                                    width: 75), .init(url: "https://static01.nyt.com/images/2024/02/15/multimedia/14blow1-gfqt/14blow1-gfqt-mediumThreeByTwo210.jpg", format: .medium, height: 140, width: 210), .init(url: "https://static01.nyt.com/images/2024/02/15/multimedia/14blow1-gfqt/14blow1-gfqt-mediumThreeByTwo440.jpg", format: .big, height: 293, width: 440)])]))
}
