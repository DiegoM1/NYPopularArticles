//
//  NYArticlesTests.swift
//  NYArticlesTests
//
//  Created by Diego Monteagudo Diaz on 17/02/24.
//

import XCTest
import SwiftData
@testable import NYArticles

@MainActor
final class NYArticlesTests: XCTestCase {

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ArticleModelData.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    private var context: ModelContext!

    var testArticle = ArticleModelData(url: "https://www.google.com",
                                   id: 10000000000,
                                   publishedDate: "2024-02-11",
                                   updated: "2024-02-13 11:35:55",
                                       section: .arts,
                                   byline: "By Mike Hale",
                                   title: "The super Bowl ads, Ranked",
                                       abstract: "Here is how our critic saw the Super Bowl commercials from the best to worst.",
                                       adxKeywords: "Actors and Actresses, photography;Cooper, Bradly;Ruffalo, Mark;Randolph", media: [ArticleMediaModel(type: "Image",
                                                                                                                                                        subtype: "photo",
                                                                                                                                                        caption: "Christopher Walken stars in a BMW ad that pokes fun at people's tendency to impersonate",
                                                                                                                                                        copyright: "BMW", mediaMetadata: [MediaMetadata(url: "https://static01.nyt.com/images/2024/02/15/multimedia/14blow1-gfqt/14blow1-gfqt-thumbStandard.jpg", format: .small,
                                                                                                                                                                                                        height: 75,
                                                                                                                                                                                                        width: 75), .init(url: "https://static01.nyt.com/images/2024/02/15/multimedia/14blow1-gfqt/14blow1-gfqt-mediumThreeByTwo210.jpg", format: .medium, height: 140, width: 210), .init(url: "https://static01.nyt.com/images/2024/02/15/multimedia/14blow1-gfqt/14blow1-gfqt-mediumThreeByTwo440.jpg", format: .big, height: 293, width: 440)])])

    override func setUpWithError() throws {
        context = sharedModelContainer.mainContext

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddItemToContext() throws {
        context.insert(testArticle)
        let fetchDescriptor = FetchDescriptor<ArticleModelData>()

        guard let contextData = try? context.fetch(fetchDescriptor) else { return }
        XCTAssertFalse(contextData.isEmpty)
    }

    func testRemoveItemToContext() throws {
        context.insert(testArticle)
        context.delete(testArticle)
        let fetchDescriptor = FetchDescriptor<ArticleModelData>()

        guard let contextData = try? context.fetch(fetchDescriptor) else { return }
        XCTAssertTrue(contextData.isEmpty)
    }

    func testTryToAddDuplicateId() throws {
        context.insert(testArticle)
        context.insert(testArticle)
        let fetchDescriptor = FetchDescriptor<ArticleModelData>()

        guard let contextData = try? context.fetch(fetchDescriptor) else { return }

        XCTAssertEqual(contextData.count, 1)
    }

    func testFetchDataCorrectly() async throws {
        let articleService = ArticleServices()
        let value = try await articleService.getArticlesBy(pathType: .shared, andPeriod: .day)
        XCTAssertFalse(value.results.isEmpty)
    }

    func testBeautifulDateFormatter() async throws {
        var stringDateFormatExample = "2024-02-16 11:49:40"
        var formatted = stringDateFormatExample.beautifulDateFormat()
        XCTAssertEqual(formatted, "Feb 16, 2024, 11:49 AM")
    }

    @MainActor
    override func tearDown() {
        try? context.delete(model: ArticleModelData.self)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
