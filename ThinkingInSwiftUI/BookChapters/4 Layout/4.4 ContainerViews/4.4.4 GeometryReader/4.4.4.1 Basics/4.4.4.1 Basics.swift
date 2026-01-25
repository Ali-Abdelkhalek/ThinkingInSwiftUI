import SwiftUI

/// # GeometryReader Basics
///
/// GeometryReader is a container that always accepts the proposed size and reports
/// that size to its view builder closure via a GeometryProxy.
///
/// IMPORTANT: GeometryReader has TWO unique behaviors:
/// 1. SIZE: Always accepts the full proposed size (unlike views that size to content)
/// 2. POSITION: Places content at top-leading (0, 0) instead of centering like other containers
///
struct GeometryReaderBasics: View {
    var body: some View {
        TabView {
            BasicGeometryReaderExample()
                .tabItem { Label("Basic", systemImage: "1.circle") }

            ProblemExample()
                .tabItem { Label("Problem", systemImage: "2.circle") }

            GeometryReaderAlignmentExample()
                .tabItem { Label("Alignment", systemImage: "3.circle") }

            FlexibleViewSolution()
                .tabItem { Label("Flexible Views", systemImage: "4.circle") }
        }
    }
}

#Preview {
    GeometryReaderBasics()
}
