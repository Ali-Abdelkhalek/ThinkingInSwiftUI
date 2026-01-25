import SwiftUI

/// # List Advanced
///
/// Advanced List behaviors including height estimation, dynamic content,
/// and comprehensive layout behavior.
///
/// KEY CONCEPTS:
/// 1. Height Proposal: List proposes nil (unlimited) for height to children
/// 2. Height Estimation: List estimates total content height from visible items
/// 3. Dynamic Heights: Each row can have different heights
/// 4. Lazy Rendering: Items are only rendered when they become visible
///
struct ListAdvanced: View {
    var body: some View {
        TabView {
            ListHeightProposalExample()
                .tabItem { Label("Height", systemImage: "1.circle") }

            HeightEstimationExample()
                .tabItem { Label("Estimation", systemImage: "2.circle") }

            DynamicHeightItemsExample()
                .tabItem { Label("Dynamic", systemImage: "3.circle") }

            ListLayoutSummary()
                .tabItem { Label("Summary", systemImage: "4.circle") }
        }
    }
}

#Preview {
    ListAdvanced()
}
