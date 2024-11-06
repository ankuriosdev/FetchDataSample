import SwiftUI

struct MealCardView: View {
    let mealDetail: MealDetail

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Meal image
//            AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
//                image.resizable()
//            } placeholder: {
//                ProgressView()
//            }
//            .frame(height: 200)
//            .cornerRadius(10)
            if let url = URL(string: mealDetail.strMealThumb) {
                CachedImageView(imageURL: url)
                    //.frame(width: UIScreen.main.bounds.width - 40, height: 250)
                    .cornerRadius(10)
            }
            // Meal title
            Text(mealDetail.strMeal)
                .font(.largeTitle)
                .bold()

            // Category and Area
            Text("\(mealDetail.strCategory) | \(mealDetail.strArea)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Instructions
            Text("Instructions")
                .font(.title2)
                .padding(.top)
            Text(mealDetail.strInstructions)
                .font(.body)

            // Ingredients and Measurements
            Text("Ingredients")
                .font(.title2)
                .padding(.top)
            VStack(alignment: .leading, spacing: 8) {
                if let ingredient1 = mealDetail.strIngredient1, !ingredient1.isEmpty {
                    Text("\(ingredient1): \(mealDetail.strMeasure1 ?? "")")
                }
                if let ingredient2 = mealDetail.strIngredient2, !ingredient2.isEmpty {
                    Text("\(ingredient2): \(mealDetail.strMeasure2 ?? "")")
                }
                // Continue for other ingredients...
            }

            // YouTube link (optional)
            if let youtubeURL = mealDetail.strYoutube, !youtubeURL.isEmpty {
                Link("Watch on YouTube", destination: URL(string: youtubeURL)!)
                    .padding(.top)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
