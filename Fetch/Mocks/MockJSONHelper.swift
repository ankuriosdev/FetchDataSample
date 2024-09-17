import Foundation

struct MockJSONHelper {
    // Load meals from MealsListing.json
    static func loadMealsFromFile() -> MealResponse? {
        guard let url = Bundle.main.url(forResource: "MealsListing", withExtension: "json") else {
            print("MealsListing.json not found")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let decodedMeals = try JSONDecoder().decode(MealResponse.self, from: data)
            return decodedMeals
        } catch {
            print("Error loading MealsListing.json: \(error)")
            return nil
        }
    }

    // Load meal details from MealDetails.json
    static func loadMealDetailsFromFile() -> MealDetailResponse? {
        guard let url = Bundle.main.url(forResource: "MealDetails", withExtension: "json") else {
            print("MealDetails.json not found")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let decodedMealDetails = try JSONDecoder().decode(MealDetailResponse.self, from: data)
            return decodedMealDetails
        } catch {
            print("Error loading MealDetails.json: \(error)")
            return nil
        }
    }
}
