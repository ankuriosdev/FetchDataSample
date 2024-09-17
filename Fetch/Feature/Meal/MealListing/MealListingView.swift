//
//  ContentView.swift
//  Fetch
//
//  Created by Ankur Chauhan on 9/15/24.
//

import SwiftUI
import CoreFoundation

struct MealListView: View {
    @StateObject private var viewModel: MealListViewModel

    init(viewModel: MealListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal, viewModel: MealDetailViewModel(mealRepository: viewModel.mealRepository))) {
                    HStack {
                        // Use CachedImageView to display the meal image
                        if let url = URL(string: meal.strMealThumb) {
                            CachedImageView(imageURL: url)
                                .frame(width: 100, height: 100)
                                .roundedCorners(10) // Use the custom view modifier here
                        }
                        /*AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        */
                        Text(meal.strMeal ?? "")
                            .font(.headline)
                    }
                }
            }
            .accessibilityIdentifier("MealListView")
            .navigationTitle("Dessert Meals")
            .task {
                await viewModel.fetchMeals()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
        }
    }
}


struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockRepository = MockMealRepository()
        let viewModel = MealListViewModel(mealRepository: mockRepository)
        MealListView(viewModel: viewModel)
    }
}
