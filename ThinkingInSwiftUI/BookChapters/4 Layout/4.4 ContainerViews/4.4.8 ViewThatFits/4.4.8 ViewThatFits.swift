import SwiftUI

/// # ViewThatFits
///
/// ViewThatFits is a container that automatically selects which view to display based on
/// available space. It tries each subview in order and picks the first one that fits.
///
/// KEY BEHAVIORS:
/// 1. Proposes nil to each subview (asks for ideal size)
/// 2. Picks FIRST subview whose ideal size fits within proposed space
/// 3. If none fit, picks LAST subview as fallback
/// 4. Order matters - always arrange from most spacious to most compact
///
/// IMPORTANT: This is NOT for complex conditional logic - it's for simple responsive
/// adaptations like horizontal vs vertical layout, full text vs abbreviated, etc.
///
struct ViewThatFitsExample: View {
    var body: some View {
        TabView {
            BasicViewThatFitsExample()
                .tabItem { Label("Basics", systemImage: "1.circle") }

            TextAdaptationExample()
                .tabItem { Label("Text Adaptation", systemImage: "2.circle") }

            ResponsiveLayoutExample()
                .tabItem { Label("Responsive", systemImage: "3.circle") }

            EdgeCasesExample()
                .tabItem { Label("Edge Cases", systemImage: "4.circle") }

            PracticalUseCasesExample()
                .tabItem { Label("Use Cases", systemImage: "5.circle") }
        }
    }
}

#Preview {
    ViewThatFitsExample()
}
