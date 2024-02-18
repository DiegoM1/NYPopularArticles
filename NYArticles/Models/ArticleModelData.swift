//
//  ArticleModelData.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import Foundation
import SwiftData

protocol ModelDataProtocol {
    var url: String { get }
    var id: Int { get }
    var publishedDate: String { get }
    var updatedTime: String? { get }
    var adxKeywords: String { get }
    var section: SectionTypes { get }
    var byline: String { get }
    var title: String { get }
    var abstract: String { get }
    var media: [ArticleMediaModel] { get }
}

@Model
final class ArticleModelData: ModelDataProtocol {
    var url: String
    @Attribute(.unique) var id: Int
    var publishedDate: String
    var updatedTime: String?
    var updatedDate: Date?
    var adxKeywords: String
    var section: SectionTypes
    var byline: String
    var title: String
    var abstract: String
    var media: [ArticleMediaModel]

    init(url: String, id: Int, publishedDate: String, updated: String, section: SectionTypes, byline: String, title: String, abstract: String, adxKeywords: String, media: [ArticleMediaModel]) {
        self.url = url
        self.id = id
        self.publishedDate = publishedDate
        self.updatedDate = updated.toDate()
        self.updatedTime = updated
        self.section = section
        self.byline = byline
        self.title = title
        self.adxKeywords = adxKeywords
        self.abstract = abstract
        self.media = media
    }
}
