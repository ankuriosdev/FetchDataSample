# Meal Listing and Detail App

This SwiftUI application demonstrates how to create a responsive and efficient app that displays a list of meals and their detailed information. The app features custom image caching, view modifiers for clean and reusable UI components, unit tests for ViewModel logic, and UI tests for user interaction.

## Features

- **Image Caching**: Custom caching of images using `NSCache` to improve performance and minimize network usage.
- **Custom View Modifiers**: Reusable view modifiers to apply consistent styling across views.
- **ProgressView for Image Loading**: Displays a loading indicator while images are being fetched from the network.
- **Meal Listing and Detail Views**: SwiftUI views that list meals and show detailed information.
- **Unit Tests**: Test cases for ViewModels to ensure business logic functions correctly.
- **UI Tests**: Automated tests that simulate user interactions to verify the app’s behavior.

---

## Architecture

This project uses the **MVVM (Model-View-ViewModel)** architecture to separate concerns and ensure that the app is scalable and testable. The structure helps maintain a clear separation of business logic (in the ViewModel) from the UI (View).

### 1. **Model**
The `Model` represents the data and business logic of the application. In this project, the `Meal` and `MealDetail` models handle the meal data, which is fetched from an external API.

### 2. **ViewModel**
The `ViewModel` is responsible for fetching data and preparing it for presentation in the UI. We have:
- **MealListViewModel**: Manages the meal listing data.
- **MealDetailViewModel**: Handles fetching and preparing meal detail data.

The ViewModel also handles state management, including loading states, error handling, and the transformation of data into a format that the `View` can easily display.

### 3. **View**
The `View` is responsible for displaying the data provided by the `ViewModel`. We use SwiftUI to build reactive views that automatically update when the ViewModel state changes.
- **MealListingView**: Displays a list of meals.
- **MealDetailView**: Shows detailed information about a selected meal.

By using **MVVM**, we ensure that:
- The app's business logic is well-organized and testable.
- The UI remains simple, focusing only on presenting data from the ViewModel.
- There's a clear separation between the logic that drives the app (ViewModel) and the UI components (View).

### 4. **Image Caching System**

The app implements a custom `ImageCache` class using `NSCache`. This cache stores downloaded images in memory, which allows for faster image loading and reduces unnecessary network requests.

### 5. **Custom View Modifiers**

To keep the UI clean and reusable, custom view modifiers have been created. These modifiers allow consistent styling like applying rounded corners to images and other views.

### 6. **Progress Indicator for Image Loading**

A `ProgressView` is displayed while images are being downloaded. Once the image is fetched, it replaces the progress indicator.

---

## Components

### 1. **Image Caching**

The `ImageCache` class is used to store images in memory and provide them on demand. It checks if an image is available in the cache before making a network request. If not cached, the image is downloaded and cached for future use.

- **Key Benefits**:
  - Reduced network usage by avoiding repeated image downloads.
  - Faster loading times for previously viewed images.
  - Customizable cache size and limits.

### 2. **Custom View Modifiers**

The custom view modifiers enable a consistent UI design. The primary example is a modifier that applies rounded corners to images and other views. This makes the code cleaner and avoids repetitive styling.

- **RoundedCornerModifier**: A reusable modifier that applies corner radii to views, ensuring consistency across the UI.

### 3. **ProgressView for Image Loading**

While images are being fetched, a `ProgressView` is shown to improve the user experience. This ensures that users know the app is actively loading content.

### 4. **Meal Listing and Detail Views**

- **MealListingView**: Displays a list of meals in a scrollable list format. Each meal includes a thumbnail image (cached) and brief details.
- **MealDetailView**: Shows detailed information about a specific meal, including its image, name, category, and instructions.

5 **MockJSONHelper**: This will make loading of mocks json easy.
---

## Testing

### 1. **Unit Tests**

Unit tests are written to ensure that the business logic in the ViewModels behaves as expected. These tests simulate different scenarios like successful data fetches and failures, ensuring the app behaves correctly in both cases.

- **ViewModels Tested**:
  - `MealListViewModel`
  - `MealDetailViewModel`

The tests focus on:
- Verifying successful data retrieval.
- Handling error states correctly.
- Ensuring UI state (loading, error messages) is updated as expected.

### 2. **UI Tests**

UI tests simulate user interactions with the app, such as:
- Navigating the meal list.
- Tapping on a meal to view its details.
- Ensuring the UI behaves as expected under different scenarios (e.g., when an error occurs).

These tests provide confidence that the user interface will behave correctly when real users interact with it.

---

## File Structure

- **ImageCache.swift**: Contains the image caching logic.
- **CachedImageView.swift**: A SwiftUI view that handles image loading and caching, including a `ProgressView` during image fetching.
- **MealListingView.swift**: Displays a list of meals using cached images and meal details.
- **MealDetailView.swift**: Displays detailed information for a selected meal, including an image, name, category, and instructions.
- **RoundedCornerModifier.swift**: A custom view modifier to apply rounded corners to any view.
- **MealListViewModel.swift**: Fetches and manages the data for the meal listing.
- **MealDetailViewModel.swift**: Fetches and manages the data for meal details.
- **Unit Tests**: Tests for ViewModels to verify business logic.
- **UI Tests**: Tests to simulate user interactions and verify the app’s UI behavior.

---

## Future Enhancements

DIContainer - for central allocation
Coordinator - for navigation



