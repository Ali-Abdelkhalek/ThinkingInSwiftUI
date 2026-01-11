//
//  ViewModifierWrappingExample.swift
//  ThinkingInSwiftUI
//
//  Demonstrates how view modifiers wrap views in layers
//  and the difference between .modifier API and View extensions
//

import SwiftUI

// MARK: - Demo View
struct ViewModifierWrappingExample: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                sectionTitle("1. Using .modifier API (Verbose)")

                Text("Hello World")
                    .modifier(BorderedModifier(color: .blue))

                sectionTitle("2. Using View Extension (Recommended)")

                Text("Hello World")
                    .bordered(color: .green)

                sectionTitle("3. Order Matters - Wrapping Demonstration")

                HStack(spacing: 20) {
                    VStack {
                        Text("Padding First")
                            .padding()
                            .background(Color.red)

                        Text("Background is inside padding")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    VStack {
                        Text("Background First")
                            .background(Color.red)
                            .padding()

                        Text("Background is outside padding")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                sectionTitle("4. Multiple Layers Visualization")

                Text("Wrapped")
                    .foregroundColor(.white)        // Layer 1
                    .padding(8)                     // Layer 2
                    .background(Color.blue)         // Layer 3
                    .padding(8)                     // Layer 4
                    .background(Color.purple)       // Layer 5
                    .padding(8)                     // Layer 6
                    .background(Color.orange)       // Layer 7
                    .cornerRadius(8)                // Layer 8

                Text("Each color represents a new parent layer")
                    .font(.caption)
                    .foregroundColor(.secondary)

                sectionTitle("5. Custom Modifier with Multiple Effects")

                Text("Styled Text")
                    .fancyStyle()

                Text("Another Styled Text")
                    .fancyStyle(color: .purple)
            }
            .padding()
        }
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
    }
}

// MARK: - Custom ViewModifier
// This demonstrates the ViewModifier protocol
struct BorderedModifier: ViewModifier {
    var color: Color

    func body(content: Content) -> some View {
        // The modifier WRAPS the content (original view) inside new layers
        // BorderedModifier becomes the PARENT of the view it's applied to
        content
            .padding()
            .background(Color.gray.opacity(0.1))
            .border(color, width: 2)
    }
}

// MARK: - View Extensions (SwiftUI's Approach)
// This is how SwiftUI's built-in modifiers like .padding(), .background(), etc. work
extension View {
    /// Applies a bordered style - cleaner than using .modifier(BorderedModifier())
    func bordered(color: Color = .blue) -> some View {
        // Under the hood, this uses .modifier API
        self.modifier(BorderedModifier(color: color))
    }

    /// A more complex modifier showing multiple layers
    func fancyStyle(color: Color = .blue) -> some View {
        self
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .background(
                LinearGradient(
                    colors: [color, color.opacity(0.7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(10)
            .shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}

// MARK: - Preview
#Preview {
    ViewModifierWrappingExample()
}

/*
 EXPLANATION:

 1. View modifiers always wrap an existing view inside another layer
    - The modifier becomes the PARENT
    - The view it's applied to becomes the CHILD

 2. The .modifier API
    - You can apply any ViewModifier using .modifier(SomeModifier())
    - This works but is verbose and less intuitive

 3. View Extensions (Best Practice)
    - SwiftUI's built-in modifiers (.padding, .background, etc.) are View extensions
    - They internally use .modifier but provide a cleaner API
    - This is the recommended approach for custom modifiers too

 4. Wrapping/Layering Hierarchy Example:

    Text("Hello")
        .padding()        // Padding wraps Text
        .background(.red) // Background wraps Padding
        .shadow(...)      // Shadow wraps Background

    Actual hierarchy:
    Shadow
      └─ Background
          └─ Padding
              └─ Text

 5. Order matters because each modifier wraps the previous view!
 */
