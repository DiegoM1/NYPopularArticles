//
//  MockArticleServices.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 18/02/24.
//

import Foundation

enum MyError: Error {
    case runtimeError(String)
}

class MockArticleServices: ArticleServicesProtocol {
    func getArticlesBy(pathType: PathsType, andPeriod period: Period) async throws -> ArticleResponse {
        return ArticleResponse(results: [ArticleModel]())
    }
}
