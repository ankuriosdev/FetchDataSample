//
//  MealListingViewModel.swift
//  Fetch
//
//  Created by Ankur Chauhan on 9/16/24.
//

import Foundation

// Protocol for ViewModel
@MainActor
protocol MealListViewModelProtocol: ObservableObject {
    var meals: [Meal] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func fetchMeals() async
}

@MainActor
class MealListViewModel: MealListViewModelProtocol {
    @Published private(set) var meals: [Meal] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    let mealRepository: MealRepository

    init(mealRepository: MealRepository) {
        self.mealRepository = mealRepository
    }

    func fetchMeals() async {
        isLoading = true
        errorMessage = nil

        do {
            self.meals = try await mealRepository.fetchMeals().meals
        } catch {
            errorMessage = "Failed to load meals: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
