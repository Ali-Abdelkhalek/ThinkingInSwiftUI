import SwiftUI

/// # Built-in Alignments
///
/// Understanding how SwiftUI's built-in alignment system works through the
/// alignment negotiation protocol between parent and child views.
///
/// KEY CONCEPTS:
/// 1. Alignment is a NEGOTIATION - parent asks child where its guides are
/// 2. Built-in guides: .leading, .center, .trailing, .top, .bottom, .firstTextBaseline, .lastTextBaseline
/// 3. Different containers use different alignment types (HStack = VerticalAlignment, VStack = HorizontalAlignment, ZStack/Frame = Alignment)
/// 4. Algorithm: Parent computes its own guide, child reports its guide, parent positions child using the difference
///
/// COVERED TOPICS:
/// - Alignment basics and the negotiation protocol
/// - Frame alignment (.frame(alignment:))
/// - Stack alignment (HStack, VStack)
/// - ZStack alignment and its 2-step algorithm
///
struct BuiltInAlignments: View {
    var body: some View {
        TabView {
            BuiltInAlignmentBasics()
                .tabItem { Label("Basics", systemImage: "1.circle") }

            FrameAlignmentExample()
                .tabItem { Label("Frame", systemImage: "2.circle") }

            StackAlignmentExample()
                .tabItem { Label("Stacks", systemImage: "3.circle") }

            ZStackAlignmentExample()
                .tabItem { Label("ZStack", systemImage: "4.circle") }
        }
    }
}

#Preview {
    BuiltInAlignments()
}
