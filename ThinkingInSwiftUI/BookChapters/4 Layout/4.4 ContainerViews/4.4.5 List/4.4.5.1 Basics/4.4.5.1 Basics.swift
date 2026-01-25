import SwiftUI

/// # List Basics
///
/// List is a container view that displays rows of data in a vertical scrolling layout.
/// It's optimized for displaying large amounts of data with automatic lazy loading.
///
/// KEY BEHAVIORS:
/// 1. Lazy Loading: Cells are created only when they're about to appear on screen
/// 2. Width Proposal: Proposes infinity width to cells (unlike ScrollView)
/// 3. Height Sizing: Flexible - adapts to content height
/// 4. Reusability: Cells are reused as they scroll off-screen (like UITableView)
///
struct ListBasics: View {
    var body: some View {
        TabView {
            BasicListExample()
                .tabItem { Label("Basic", systemImage: "1.circle") }

            LazyLoadingExample()
                .tabItem { Label("Lazy Loading", systemImage: "2.circle") }

            ListVsScrollViewComparison()
                .tabItem { Label("vs ScrollView", systemImage: "3.circle") }

            ListWidthProposalExample()
                .tabItem { Label("Width", systemImage: "4.circle") }
        }
    }
}

#Preview {
    ListBasics()
}
