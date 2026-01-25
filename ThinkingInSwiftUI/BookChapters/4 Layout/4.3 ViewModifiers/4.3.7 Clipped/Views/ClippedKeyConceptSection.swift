//
//  ClippedKeyConceptSection.swift
//  ThinkingInSwiftUI
//
//  Key concepts of .clipped() modifier
//

import SwiftUI

struct ClippedKeyConceptSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("The Critical Distinction:")
                .font(.headline)

            VStack(alignment: .leading, spacing: 8) {
                conceptItem(
                    symbol: "✅",
                    title: "What .clipped() DOES:",
                    description: "Clips visual rendering of content that extends beyond the view's bounds",
                    color: .green
                )

                conceptItem(
                    symbol: "❌",
                    title: "What .clipped() does NOT do:",
                    description: "Does NOT change the view's frame size or remove empty space",
                    color: .red
                )
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Think of it like this:")
                    .fontWeight(.semibold)
                    .padding(.top, 8)

                Text("• Frame size = what the layout system sees")
                Text("• Visual rendering = what you see on screen")
                Text("• .clipped() only affects visual rendering")
                Text("• Frame size stays exactly the same!")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }

    private func conceptItem(symbol: String, title: String, description: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(symbol)
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(color)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    ScrollView {
        ClippedKeyConceptSection()
            .padding()
    }
}
