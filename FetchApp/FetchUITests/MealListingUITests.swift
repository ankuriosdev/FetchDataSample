//
//  MealListingUITests.swift
//  FetchUITests
//
//  Created by Ankur Chauhan on 9/15/24.
//

import XCTest

class MealListingUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    func testMealListIsLoaded() {
        // Verify that the meal list table is visible
        let mealTable = app.collectionViews["MealListView"]
        XCTAssertTrue(mealTable.exists, "Meal list table should be visible")

        // Verify that at least one meal cell is loaded
        let firstCell = mealTable.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "At least one meal should be loaded into the list")
    }

    func testTapOnMealShowsMealDetail() {
        // Verify the meal list is loaded
        let mealTable = app.collectionViews["MealListView"]
        XCTAssertTrue(mealTable.exists, "Meal list table should be visible")

        // Tap on the first meal in the list
        let firstMeal = mealTable.cells.element(boundBy: 0)
        XCTAssertTrue(firstMeal.exists, "First meal should be visible")
        firstMeal.tap()

        // Verify that the meal detail screen is presented
        let mealDetailLabel = app.staticTexts["Meal Details"]
        XCTAssertTrue(mealDetailLabel.exists, "Meal detail should be shown after tapping on a meal")

        // Optionally, you can verify specific details
        XCTAssertEqual(mealDetailLabel.label, "Apam balik", "Expected the meal detail to match the selected meal")
    }

    func testMealListErrorHandling() {
        // Assuming an error message appears in case of failure to load meals
        let errorLabel = app.staticTexts["ErrorLabel"]
        XCTAssertFalse(errorLabel.exists, "Error message should not be visible initially")

        // You can simulate an error condition here (if mock is allowed)

        // Verify the error label appears when meals fail to load
        XCTAssertTrue(errorLabel.exists, "Error message should be visible if meal loading fails")
    }
}
