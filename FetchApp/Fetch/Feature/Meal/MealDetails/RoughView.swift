import SwiftUI

// Define the custom view modifier
struct FontAndShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .gray, radius: 5, x: 2, y: 2) // Apply shadow
            .font(.largeTitle) // Apply a specific font style
            .fontWeight(.bold)
    }
}

// Extend View to use the modifier easily
extension View {
    func applyFontAndShadow() -> some View {
        self.modifier(FontAndShadowModifier())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            // Text with custom view modifier
            Text("Custom Font and Shadow")
                .applyFontAndShadow() // Use the custom modifier here
                .padding()

            // Text without custom modifier for comparison
            Text("No Modifier Applied")
                .shadow(color: .gray, radius: 5, x: 2, y: 2)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
