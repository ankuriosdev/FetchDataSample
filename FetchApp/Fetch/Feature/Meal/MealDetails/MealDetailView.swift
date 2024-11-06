import SwiftUI

struct MealDetailView: View {
    let mealId: String
    @StateObject private var viewModel: MealDetailViewModel

    init(mealId: String, viewModel: MealDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.mealId = mealId
    }

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.mealDetails, id: \.idMeal) { mealDetail in
                        MealCardView(mealDetail: mealDetail)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchMealDetails(mealId: mealId)
            }
        }
        .navigationTitle("Meal Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockRepository = MockMealRepository()
        let viewModel = MealDetailViewModel(mealRepository: mockRepository)
        MealDetailView(mealId: "52768", viewModel: viewModel)
    }
}
