//
//  AspectRatioSolution.swift
//  ThinkingInSwiftUI
//
//  Shows how aspectRatio modifier solves the distortion problem
//

import SwiftUI

struct AspectRatioSolution: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "WITH aspectRatio - Image Maintains Proportions",
                description: "aspectRatio modifier filters the proposal",
                code: "Color.blue.aspectRatio(contentMode: .fit)"
            ) {
                VStack(spacing: 12) {
                    // Simulating aspect ratio behavior
                    Color.blue
                        .overlay(
                            Text("Original: 100×30\nProposed to modifier: 200×200\nProposed to image: 200×60\nResult: 200×60")
                                .font(.caption)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        )
                        .frame(width: 200, height: 60)
                        .frame(width: 200, height: 200)
                        .border(Color.red, width: 2)

                    Text("aspectRatio modifier sits between container and image, proposing 200×60 instead!")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }

            exampleCard(
                title: "Why 200×60?",
                description: "Aspect ratio calculation",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Given:")
                        .fontWeight(.semibold)
                    Text("• Original image: 100×30")
                    Text("• Aspect ratio: 100/30 = 3.33:1")
                    Text("• Proposed size: 200×200")

                    Divider()

                    Text("Calculation (.fit mode):")
                        .fontWeight(.semibold)
                    Text("• Option 1: Use full width (200)")
                    Text("  → Height = 200 / 3.33 = 60 ✅")
                    Text("• Option 2: Use full height (200)")
                    Text("  → Width = 200 × 3.33 = 666.67 ❌ (too wide!)")

                    Divider()

                    Text("Result: 200×60")
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                }
                .font(.caption)
            }
        }
    }
}

#Preview {
    ScrollView {
        AspectRatioSolution()
            .padding()
    }
}
