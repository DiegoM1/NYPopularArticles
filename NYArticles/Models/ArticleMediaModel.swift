//
//  Media.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import Foundation

struct ArticleMediaModel: Codable {
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
    let mediaMetadata: [MediaMetadata]

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright, mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    let url: String
    let format: ImageFormatSize
    let height: Int
    let width: Int

    var realUrl: URL {
        URL(string: url)!
    }
}

enum ImageFormatSize: String, Codable {
    case small = "Standard Thumbnail"
    case medium = "mediumThreeByTwo210"
    case big = "mediumThreeByTwo440"
}
