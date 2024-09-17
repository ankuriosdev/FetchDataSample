//
//  FetchUITestsLaunchTests.swift
//  FetchUITests
//
//  Created by Ankur Chauhan on 9/15/24.
//

import XCTest

class MealDetailUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Setup to launch the app
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testMealDetailDisplaysCorrectInformation() {
        // Navigate to the detail view
        let mealTable = app.collectionViews["Meal List"]
        XCTAssertTrue(mealTable.exists, "Meal list table should be visible")
        
        let firstMeal = mealTable.cells.element(boundBy: 0)
        firstMeal.tap()

        // Verify that the meal detail label displays correct information
        let mealDetailLabel = app.staticTexts["Meal Details"]
        XCTAssertTrue(mealDetailLabel.exists, "Meal detail label should be visible")

        // Optionally, assert specific meal details
        XCTAssertEqual(mealDetailLabel.label, "Apple Frangipan Tart", "Expected the meal detail to match the selected meal")
    }

    func testMealDetailBackNavigation() {
        // Tap on a meal to show details
        let mealTable = app.collectionViews["MealList"]
        let firstMeal = mealTable.cells.element(boundBy: 0)
        firstMeal.tap()

        // Assert the detail screen is shown
        let mealDetailLabel = app.staticTexts["Meal Details"]
        XCTAssertTrue(mealDetailLabel.exists, "Meal detail should be shown after tapping on a meal")

        // Go back to the meal list
        app.navigationBars.buttons["Back"].tap()

        // Verify we are back on the meal list screen
        XCTAssertTrue(mealTable.exists, "We should be back on the meal list screen")
    }
}
