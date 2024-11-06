//
//  MealRepositary.swift
//  Fetch
//
//  Created by Ankur Chauhan on 9/16/24.
//
import Foundation

protocol MealRepository {
    /// Fetches a list of meals from a specific category.
    /// - Returns: A `MealResponse` containing an array of `Meal` objects.
    func fetchMeals() async throws -> MealResponse
    
    /// Fetches detailed information about a specific meal by its ID.
    /// - Parameter mealId: The ID of the meal to fetch details for.
    /// - Returns: A `MealDetailResponse` containing an array of `MealDetail` objects.
    func fetchMealDetails(mealId: String) async throws -> MealDetailResponse
}

class DefaultMealRepository: MealRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    /// Fetches a list of meals from the "Dessert" category.
    /// - Returns: A `MealResponse` containing a list of meals.
    func fetchMeals() async throws -> MealResponse {
        guard let url = URLManager.mealsByCategoryURL(category: "Dessert") else {
            throw NetworkError.badURL
        }
        // Uses the network service to fetch and decode the response
        return try await networkService.fetchData(url: url)
    }

    /// Fetches detailed information about a specific meal by its ID.
    /// - Parameter mealId: The ID of the meal to fetch details for.
    /// - Returns: A `MealDetailResponse` containing meal details.
    func fetchMealDetails(mealId: String) async throws -> MealDetailResponse {
        guard let url = URLManager.mealDetailsURL(mealId: mealId) else {
            throw NetworkError.badURL
        }
        // Uses the network service to fetch and decode the response
        return try await networkService.fetchData(url: url)
    }
}


