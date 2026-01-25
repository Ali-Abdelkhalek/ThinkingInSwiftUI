//
//  LayoutVsRenderingWithoutClippingSection.swift
//  ThinkingInSwiftUI
//
//  Shows layout without clipping
//

import SwiftUI

struct LayoutVsRenderingWithoutClippingSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Without .clipped() - Rendering Can Overflow",
                description: "Content draws beyond layout bounds",
                code: ".frame(width: 100)"
            ) {
                VStack(spacing: 16) {
                    // Visual demonstration
                    HStack(spacing: 0) {
                        // The frame - WITHOUT clipping
                        ZStack {
                            // Rendered content (will overflow)
                            Circle()
                                .fill(Color.red.opacity(0.3))
                                .frame(width: 150, height: 150)

                            // Layout boundary visualization
                            Rectangle()
                                .stroke(Color.blue, lineWidth: 2)
                                .frame(width: 100, height: 60)
                        }
                        .frame(width: 100, height: 60)
                        // NO .clipped() here - circle overflows!

                        // Next sibling view
                        Text("Next View")
                            .font(.caption)
                            .padding(8)
                            .background(Color.green.opacity(0.3))
                            .border(Color.green, width: 2)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        legendItem(color: .blue, text: "Blue border = Layout space (100×60)")
                        legendItem(color: .red, text: "Red circle = Rendered content (150×150, overflows!)")
                        legendItem(color: .green, text: "Green view = Next sibling (positioned at 100pt)")
                    }
                    .font(.caption)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("What happens:")
                            .fontWeight(.semibold)

                        Text("• ZStack with 150×150 circle inside")
                        Text("• .frame(width: 100, height: 60) constrains layout to 100×60")
                        Text("• Circle still renders at 150×150 (overflows!)")
                        Text("• Sibling: Green view positioned at 100pt mark")
                        Text("• Result: Layout = 100×60, Rendering = 150×150")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Layout Space vs Visual Rendering",
                description: "They can be different!",
                code: ""
            ) {
                VStack(spacing: 12) {
                    // Show the concept
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Layout Space (what other views see):")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Rectangle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 100, height: 40)
                            .overlay(
                                Text("100pt")
                                    .font(.caption)
                            )
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Visual Rendering (what you see):")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Circle()
                            .fill(Color.red.opacity(0.3))
                            .frame(width: 150, height: 150)
                    }

                    Text("These are TWO DIFFERENT things!\nLayout = 100pt, Rendering = 150pt (overflows!)")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        LayoutVsRenderingWithoutClippingSection()
            .padding()
    }
}
