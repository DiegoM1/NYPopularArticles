//
//  ArticleServices.swift
//  NYArticles
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import Foundation

protocol ArticleServicesProtocol{
    func getArticlesBy(pathType: PathsType, andPeriod period: Period) async throws -> ArticleResponse
}

class ArticleServices: ArticleServicesProtocol {
    private let defaultPath = "https://api.nytimes.com/svc/mostpopular/v2/"

    func getArticlesBy(pathType: PathsType, andPeriod period: Period) async throws -> ArticleResponse {

        guard let apiKey = Bundle.main.infoDictionary?["Api_key"] as? String  else {
            fatalError("**WARNING** Api key cant be found")
        }
        let url = URL(string: defaultPath + pathType.rawValue + "/\(period.rawValue).json?api-key=\(apiKey)")!
        print(url)
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let fetchedData = try decoder.decode(ArticleResponse.self, from: data)
        return fetchedData
    }
} 
