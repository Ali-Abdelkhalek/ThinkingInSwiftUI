import SwiftUI

/// # GeometryReader Advanced
///
/// Advanced techniques for using GeometryReader correctly:
/// - Using GeometryReader in background/overlay modifiers
/// - Reading geometry values comprehensively
/// - Centering content properly
/// - Measuring dynamic content with PreferenceKeys
///
struct GeometryReaderAdvanced: View {
    var body: some View {
        TabView {
            BackgroundOverlaySolution()
                .tabItem { Label("Background", systemImage: "1.circle") }

            ComprehensiveGeometryExample()
                .tabItem { Label("Comprehensive", systemImage: "2.circle") }

            CenteringInGeometryReader()
                .tabItem { Label("Centering", systemImage: "3.circle") }

            MeasuringDynamicContent()
                .tabItem { Label("Dynamic", systemImage: "4.circle") }
        }
    }
}

#Preview {
    GeometryReaderAdvanced()
}
