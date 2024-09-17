import Foundation

class MockMealRepository: MealRepository {

    // This flag simulates whether the repository should return an error
    var shouldReturnError = false
    
    // Simulate fetching meals
    func fetchMeals() async throws -> MealResponse {
        if shouldReturnError {
            throw NSError(domain: "MockError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch meals"])
        } else {
            // Use MockJSONHelper to load meals from MealsListing.json
            if let mealResponse = MockJSONHelper.loadMealsFromFile() {
                return mealResponse
            } else {
                throw NSError(domain: "MockError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to load meals from file"])
            }
        }
    }
    
    // Simulate fetching meal details
    func fetchMealDetails(mealId: String) async throws -> MealDetailResponse {
        if shouldReturnError {
            throw NSError(domain: "MockError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch meal details"])
        } else {
            // Use MockJSONHelper to load meal details from MealDetails.json
            if let mealDetailResponse = MockJSONHelper.loadMealDetailsFromFile() {
                return mealDetailResponse
            } else {
                throw NSError(domain: "MockError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to load meal details from file"])
            }
        }
    }
}
