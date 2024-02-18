//
//  ArticleModel.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import Foundation
import SwiftData

struct ArticleResponse: Codable {
    let results: [ArticleModel]
}

struct ArticleModel: Codable, Identifiable, ModelDataProtocol {
    let url: String
    let id: Int
    let publishedDate: String
    let updated: String
    var updatedTime: String? {
        return updated
    }
    let section: SectionTypes
    let byline: String
    let title: String
    let adxKeywords: String
    let abstract: String
    let media: [ArticleMediaModel]
}
