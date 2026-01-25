import SwiftUI

/// # Grid (iOS 16+)
///
/// Grid is a container view that creates a 2D grid layout with explicit row definitions.
/// Unlike LazyVGrid/LazyHGrid which use auto-flow, Grid gives precise control over
/// row and column structure.
///
/// KEY CHARACTERISTICS:
/// 1. Row-Oriented: Define rows explicitly with GridRow
/// 2. Column Coordination: Columns auto-align across all rows
/// 3. Non-Lazy: All cells created immediately
/// 4. Two-Pass Layout: First pass determines sizes, second pass renders
///
/// ⚠️ Note: Grid was considered unstable in iOS 16-17 when "Thinking in SwiftUI" was written.
///
struct GridExplained: View {
    var body: some View {
        TabView {
            WhyGridsExample()
                .tabItem { Label("Why Grids?", systemImage: "1.circle") }

            GridBasicsExample()
                .tabItem { Label("Basics", systemImage: "2.circle") }

            GridColumnSizing()
                .tabItem { Label("Sizing", systemImage: "3.circle") }

            GridLayoutAlgorithm()
                .tabItem { Label("Algorithm", systemImage: "4.circle") }

            GridModifiersExample()
                .tabItem { Label("Modifiers", systemImage: "5.circle") }
        }
    }
}

#Preview {
    GridExplained()
}
