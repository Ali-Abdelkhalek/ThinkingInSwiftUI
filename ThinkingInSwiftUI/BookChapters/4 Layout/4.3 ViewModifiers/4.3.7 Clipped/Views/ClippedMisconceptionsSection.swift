//
//  ClippedMisconceptionsSection.swift
//  ThinkingInSwiftUI
//
//  Common misconceptions about .clipped()
//

import SwiftUI

struct ClippedMisconceptionsSection: View {
    var body: some View {
        VStack(spacing: 20) {
            misconceptionCard(
                myth: "Myth: .clipped() removes empty space",
                reality: "Reality: .clipped() only crops overflow, doesn't change frame size",
                example: "A 200pt wide frame with 50pt content stays 200pt wide after .clipped()"
            )

            misconceptionCard(
                myth: "Myth: .clipped() shrinks the view to fit content",
                reality: "Reality: Use .fixedSize() to shrink views to content size",
                example: ".fixedSize() changes layout, .clipped() only changes rendering"
            )

            misconceptionCard(
                myth: "Myth: .clipped() affects layout of sibling views",
                reality: "Reality: Sibling views are positioned based on frame size, not clipped content",
                example: "Views next to clipped content don't move closer"
            )

            misconceptionCard(
                myth: "Myth: .clipped() is needed when there's empty space",
                reality: "Reality: .clipped() is needed when content overflows beyond bounds",
                example: "Empty space = use .fixedSize() or adjust frame. Overflow = use .clipped()"
            )
        }
    }

    private func misconceptionCard(myth: String, reality: String, example: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                Text("❌")
                Text(myth)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
            }

            HStack(alignment: .top, spacing: 8) {
                Text("✅")
                Text(reality)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }

            Text(example)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 4)
        }
        .padding()
        .background(Color.yellow.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    ScrollView {
        ClippedMisconceptionsSection()
            .padding()
    }
}
