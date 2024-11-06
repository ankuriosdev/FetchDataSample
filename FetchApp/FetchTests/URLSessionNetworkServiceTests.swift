//
//  URLSessionNetworkServiceTests.swift
//  FetchTests
//
//  Created by Ankur Chauhan on 9/16/24.
//

import XCTest
@testable import Fetch

struct MockMeal: Decodable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

class URLSessionNetworkServiceTests: XCTestCase {

    var networkService: URLSessionNetworkService!
    
    override func setUp() {
        super.setUp()
        
        // Set up a URLSession with the MockURLProtocol
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        networkService = URLSessionNetworkService(session: session)
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    func testFetchDataSuccess() async throws {
        // Prepare mock response data
        let mockResponse = """
        {
            "idMeal": "52768",
            "strMeal": "Apple Frangipan Tart",
            "strMealThumb": "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg"
        }
        """.data(using: .utf8)
        
        MockURLProtocol.mockData = mockResponse
        MockURLProtocol.mockError = nil
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        
        do {
            let meal: MockMeal = try await networkService.fetchData(url: url)
            XCTAssertEqual(meal.idMeal, "52768")
            XCTAssertEqual(meal.strMeal, "Apple Frangipan Tart")
        } catch {
            XCTFail("Expected successful decoding, but got error: \(error)")
        }
    }

    func testFetchDataFailure() async throws {
        // Prepare mock error
        MockURLProtocol.mockError = NSError(domain: "com.mock.error", code: 404, userInfo: nil)
        MockURLProtocol.mockData = nil
        
        let url = URL(string: "https://invalid.url")!
        
        do {
            let _: MockMeal = try await networkService.fetchData(url: url)
            XCTFail("Expected failure, but got success")
        } catch {
            XCTAssertNotNil(error, "Expected an error but got none")
        }
    }
}
