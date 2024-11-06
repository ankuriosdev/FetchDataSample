//
//  APIEndpoints.swift
//  Fetch
//
//  Created by Ankur Chauhan on 9/15/24.
//

import Foundation

class URLManager {
    static let baseURL = "https://themealdb.com/api/json/v1/1/"

    // Endpoint for fetching meals by category
    static func mealsByCategoryURL(category: String) -> URL? {
        return URL(string: "\(baseURL)filter.php?c=\(category)")
    }

    // Endpoint for fetching meal details by ID
    static func mealDetailsURL(mealId: String) -> URL? {
        return URL(string: "\(baseURL)lookup.php?i=\(mealId)")
    }
}
