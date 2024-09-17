//
//  NetworkingLayerTests.swift
//  FetchTests
//
//  Created by Ankur Chauhan on 9/16/24.
//

import XCTest
@testable import Fetch

class MealDetailViewModelTests: XCTestCase {

    var viewModel: MealDetailViewModel!
    var mockRepository: MockMealRepository!

    @MainActor
    override func setUp() {
        super.setUp()
        mockRepository = MockMealRepository()
        viewModel = MealDetailViewModel(mealRepository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    @MainActor
    func testFetchMealDetailsSuccess() async {
        // Arrange: Simulate a successful response from MockMealRepository
        mockRepository.shouldReturnError = false

        // Act: Call fetchMealDetails with a valid meal ID
        await viewModel.fetchMealDetails(mealId: "52768")

        // Assert: Verify the ViewModel state
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetch completes")
        XCTAssertEqual(viewModel.mealDetails.count, 1, "There should be 1 meal in mealDetails")
        XCTAssertEqual(viewModel.mealDetails.first?.idMeal, "52768", "Expected meal ID to match")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil on success")
    }

    @MainActor
    func testFetchMealDetailsFailure() async {
        // Arrange: Simulate a failure response from MockMealRepository
        mockRepository.shouldReturnError = true

        // Act: Call fetchMealDetails with a valid meal ID but expect failure
        await viewModel.fetchMealDetails(mealId: "52768")

        // Assert: Verify the ViewModel state
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetch completes")
        XCTAssertEqual(viewModel.mealDetails.count, 0, "Meal details should be empty on failure")
        XCTAssertNotNil(viewModel.errorMessage, "Expected an error message on failure")
    }
}
