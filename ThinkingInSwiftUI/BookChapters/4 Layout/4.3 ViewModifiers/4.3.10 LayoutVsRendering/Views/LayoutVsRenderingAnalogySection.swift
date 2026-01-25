//
//  LayoutVsRenderingAnalogySection.swift
//  ThinkingInSwiftUI
//
//  Real-world analogy for layout vs rendering
//

import SwiftUI

struct LayoutVsRenderingAnalogySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Real-World Analogy: The Picture Frame")
                .font(.headline)

            analogyCard(
                title: "Layout = The Frame on the Wall",
                description: "The physical space the frame occupies",
                details: [
                    "Takes up 100cm × 100cm on your wall",
                    "This space is reserved - nothing else can go there",
                    "Other frames positioned based on this space",
                    "This NEVER changes"
                ],
                color: .blue
            )

            analogyCard(
                title: "Rendering = The Painting Inside",
                description: "What actually gets displayed",
                details: [
                    "The painting might be larger than 100cm × 100cm",
                    "Without clipping: painting extends beyond frame edges",
                    "With clipping: mat/glass cuts off overflow",
                    "But frame STILL occupies same wall space!"
                ],
                color: .orange
            )

            Text("The wall space (layout) doesn't change just because you trim the painting (rendering)!")
                .font(.subheadline)
                .foregroundColor(.green)
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(8)
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    private func analogyCard(title: String, description: String, details: [String], color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(color)

            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)

            ForEach(details, id: \.self) { detail in
                HStack(alignment: .top, spacing: 4) {
                    Text("•")
                    Text(detail)
                }
                .font(.caption)
            }
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    ScrollView {
        LayoutVsRenderingAnalogySection()
            .padding()
    }
}
