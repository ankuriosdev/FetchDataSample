//
//  MealListViewModelTests.swift
//  FetchTests
//
//  Created by Ankur Chauhan on 9/16/24.
//

import XCTest
@testable import Fetch


class MealListViewModelTests: XCTestCase {

    var viewModel: MealListViewModel!
    var mockRepository: MockMealRepository!

    @MainActor
    override func setUp() {
        super.setUp()
        mockRepository = MockMealRepository()
        viewModel = MealListViewModel(mealRepository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    @MainActor
    func testFetchMealsSuccess() async {
        // Arrange: Simulate a successful response from MockMealRepository
        mockRepository.shouldReturnError = false

        // Act: Call fetchMeals
        await viewModel.fetchMeals()

        // Assert: Verify the ViewModel state
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetch completes")
        XCTAssertEqual(viewModel.meals.count, 65, "There should be 65 meals in meals array")
        XCTAssertEqual(viewModel.meals.first?.idMeal, "53049", "Expected first meal ID to match")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil on success")
    }

    @MainActor
    func testFetchMealsFailure() async {
        // Arrange: Simulate a failure response from MockMealRepository
        mockRepository.shouldReturnError = true

        // Act: Call fetchMeals
        await viewModel.fetchMeals()

        // Assert: Verify the ViewModel state
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetch completes")
        XCTAssertEqual(viewModel.meals.count, 0, "Meals array should be empty on failure")
        XCTAssertNotNil(viewModel.errorMessage, "Expected an error message on failure")
    }
}

