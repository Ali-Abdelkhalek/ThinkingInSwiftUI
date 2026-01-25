//
//  4.3.10 LayoutVsRendering.swift
//  ThinkingInSwiftUI
//
//  Understanding the difference between Layout and Rendering
//  Layout = space allocation in the view hierarchy
//  Rendering = what actually gets drawn on screen
//

import SwiftUI

struct LayoutVsRendering: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Layout vs Rendering")

                LayoutVsRenderingKeyConceptSection()

                sectionHeader("1. The Two-Phase System")

                LayoutVsRenderingTwoPhasesSection()

                sectionHeader("2. Layout Without Clipping")

                LayoutVsRenderingWithoutClippingSection()

                sectionHeader("3. Layout With Clipping")

                LayoutVsRenderingWithClippingSection()

                sectionHeader("4. Sibling Positioning")

                LayoutVsRenderingSiblingPositioningSection()

                sectionHeader("5. Interactive Demonstration")

                LayoutVsRenderingInteractiveDemoSection()

                sectionHeader("6. Real-World Analogy")

                LayoutVsRenderingAnalogySection()
            }
            .padding()
        }
    }
}

#Preview {
    LayoutVsRendering()
}
