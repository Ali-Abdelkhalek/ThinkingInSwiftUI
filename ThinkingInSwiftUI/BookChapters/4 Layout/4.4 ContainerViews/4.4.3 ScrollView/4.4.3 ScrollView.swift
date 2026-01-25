import SwiftUI

/// # ScrollView
///
/// ScrollView is a container that creates a scrollable region for content that exceeds
/// the available space. It has unique layout behaviors:
///
/// KEY BEHAVIORS:
/// 1. Size Acceptance: Accepts the proposed size (like a container)
/// 2. Width Proposal: Proposes its own width to children
/// 3. Height Proposal: Proposes nil (unlimited) along scroll axis
/// 4. Content Sizing: Final size determined by widest/tallest child
///
/// IMPORTANT: Text and shapes have surprising behaviors in ScrollView due to how
/// they respond to the nil proposal along the scroll axis.
///
struct ScrollViewExample: View {
    var body: some View {
        TabView {
            BasicScrollViewExample()
                .tabItem { Label("Basic", systemImage: "1.circle") }

            TextWrappingProblem()
                .tabItem { Label("Text Problem", systemImage: "2.circle") }

            TextWrappingFixed()
                .tabItem { Label("Text Fixed", systemImage: "3.circle") }

            ShapeInScrollViewProblem()
                .tabItem { Label("Shape Problem", systemImage: "4.circle") }

            ShapeInScrollViewFixed()
                .tabItem { Label("Solutions", systemImage: "5.circle") }
        }
    }
}

#Preview {
    ScrollViewExample()
}
