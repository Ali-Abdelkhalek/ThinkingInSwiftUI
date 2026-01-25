//
//  OverlayTwoStepProcessSection.swift
//  ThinkingInSwiftUI
//
//  Explains the two-step sizing process of overlay and background
//

import SwiftUI

struct OverlayTwoStepProcessSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "The Two-Step Sizing Algorithm",
                description: "How background/overlay determine sizes",
                code: "Text(\"Hello\").background(Color.teal)"
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    stepBox(
                        number: "1",
                        title: "Size Primary First",
                        description: "Background/overlay asks primary view for its size",
                        example: "Text(\"Hello\") reports 44×17",
                        color: .blue
                    )

                    Text("↓")
                        .font(.title)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)

                    stepBox(
                        number: "2",
                        title: "Propose to Secondary",
                        description: "Takes primary's size and proposes it to secondary",
                        example: "Color.teal receives proposal: 44×17",
                        color: .green
                    )

                    Text("↓")
                        .font(.title)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)

                    stepBox(
                        number: "3",
                        title: "Report Primary's Size",
                        description: "ALWAYS reports primary's size, ignoring secondary!",
                        example: "background reports: 44×17 (Text's size)",
                        color: .orange
                    )

                    Text("Result: Secondary becomes exactly the same size as primary!")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.purple)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(8)
                }
            }

            exampleCard(
                title: "Visual Demonstration",
                description: "See the sizing in action",
                code: ""
            ) {
                VStack(spacing: 16) {
                    // Show the actual example
                    Text("Hello")
                        .background(Color.teal)
                        .overlay(
                            GeometryReader { geo in
                                Text("Size: \(Int(geo.size.width))×\(Int(geo.size.height))")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .offset(y: 20)
                            }
                        )

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Notice:")
                            .fontWeight(.semibold)
                        Text("• Text size: ~44×17")
                        Text("• Teal background: exactly 44×17")
                        Text("• Background perfectly fits text!")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        OverlayTwoStepProcessSection()
            .padding()
    }
}
