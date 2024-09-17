//
//  MealDetails.swift
//  Fetch
//
//  Created by Ankur Chauhan on 9/15/24.
//

import Foundation

@MainActor
protocol MealDetailViewModelProtocol: ObservableObject {
    var mealDetails: [MealDetail] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func fetchMealDetails(mealId: String) async
}


@MainActor
class MealDetailViewModel: MealDetailViewModelProtocol {
    @Published private(set) var mealDetails: [MealDetail] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let mealRepository: MealRepository

    init(mealRepository: MealRepository) {
        self.mealRepository = mealRepository
    }

    // Fetches multiple meal details for display
    func fetchMealDetails(mealId: String) async {
        isLoading = true
        errorMessage = nil

        do {
            self.mealDetails = try await mealRepository.fetchMealDetails(mealId: mealId).meals
        } catch let error as NetworkError {
            switch error {
            case .userError(let description):
                errorMessage = description
            case .systemError, .decodingError, .badURL, .invalidResponse:
                errorMessage = "Something went wrong. Please try again."
            }
        } catch {
            errorMessage = "Unexpected error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}
