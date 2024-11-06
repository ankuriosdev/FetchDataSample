//
//  FetchApp.swift
//  Fetch
//
//  Created by Ankur Chauhan on 9/15/24.
//

import SwiftUI

@main
struct FetchApp: App {
    var body: some Scene {
        WindowGroup {
            // can be improved by DI and coordinator
            let networkService = URLSessionNetworkService()
            let mealRepository = DefaultMealRepository(networkService: networkService)
            let mealListViewModel = MealListViewModel(mealRepository: mealRepository)
            MealListView(viewModel: mealListViewModel)
        }
    }
}
