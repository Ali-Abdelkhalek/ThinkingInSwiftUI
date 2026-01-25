import SwiftUI

/// # HStack and VStack Layout Algorithm
///
/// HStacks and VStacks work intuitively — until they don't!
/// The stack layout algorithm is quite complex and can produce surprising results.
///
/// ## Key Concepts:
/// 1. Stacks divide space based on FLEXIBILITY, not fairness
/// 2. Flexibility = difference between width at ∞ proposal and 0 proposal (PROBING)
/// 3. Stack proposes remainingWidth/remainingViews to each subview (least flexible first)
/// 4. layoutPriority() changes the order of proposals
/// 5. Horizontal and vertical stacks work the same way, just with different major axis
///
struct HStackVStackExample: View {
    var body: some View {
        TabView {
            HStackVStackLayoutAlgorithm()
                .tabItem { Label("Regular Stack Algorithm", systemImage: "square.stack") }

            LazyStackComparison()
                .tabItem { Label("Lazy Stacks", systemImage: "square.stack.fill") }
        }
    }
}

#Preview {
    HStackVStackExample()
}
