//
//  LayoutVsRenderingKeyConceptSection.swift
//  ThinkingInSwiftUI
//
//  Key concepts of layout vs rendering
//

import SwiftUI

struct LayoutVsRenderingKeyConceptSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("YES! You've got it exactly right!")
                .font(.headline)
                .foregroundColor(.green)

            VStack(alignment: .leading, spacing: 8) {
                Text("The Perfect Metaphor:")
                    .font(.headline)
                    .foregroundColor(.blue)

                HStack(spacing: 12) {
                    Text("📋")
                        .font(.title)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Layout = The Plan")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        Text("Decides sizes and positions")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                HStack(spacing: 12) {
                    Text("🎨")
                        .font(.title)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Rendering = The Execution")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                        Text("Can go off-plan! (overflow, bleeding, conflicts)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color.purple.opacity(0.1))
            .cornerRadius(8)

            Text("SwiftUI has TWO separate phases:")
                .fontWeight(.semibold)
                .padding(.top, 8)

            phaseCard(
                number: "1",
                title: "Layout Phase",
                description: "Determines how much SPACE each view occupies and where it's positioned",
                color: .blue,
                details: [
                    "Measures view sizes",
                    "Positions views in the hierarchy",
                    "Allocates space",
                    "This NEVER changes with .clipped()"
                ]
            )

            phaseCard(
                number: "2",
                title: "Rendering Phase",
                description: "Actually DRAWS the content on screen (pixels)",
                color: .orange,
                details: [
                    "Draws shapes, text, images",
                    "Applies colors and effects",
                    "Can overflow beyond layout bounds",
                    "This is what .clipped() affects"
                ]
            )

            VStack(alignment: .leading, spacing: 8) {
                Text("The Key Insight:")
                    .fontWeight(.semibold)
                    .padding(.top, 8)

                Text(".clipped() creates a RENDERING MASK that prevents drawing outside the frame, but:")
                    .font(.subheadline)
                    .foregroundColor(.orange)

                VStack(alignment: .leading, spacing: 4) {
                    Text("• The LAYOUT SPACE remains unchanged")
                    Text("• The RENDERING SIZE remains unchanged")
                    Text("• Only what's VISIBLE changes (clipped at boundary)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 4)

                Text("Example: 150×150 circle in 100×60 frame with .clipped()")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.top, 4)

                VStack(alignment: .leading, spacing: 2) {
                    Text("• Layout: 100×60 (frame size)")
                    Text("• Rendering: 150×150 (circle still draws at full size)")
                    Text("• Visible: Only the 100×60 portion (masked!)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    private func phaseCard(number: String, title: String, description: String, color: Color, details: [String]) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(number)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(color)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(color)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                ForEach(details, id: \.self) { detail in
                    HStack(alignment: .top, spacing: 4) {
                        Text("•")
                        Text(detail)
                    }
                    .font(.caption)
                }
            }
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    ScrollView {
        LayoutVsRenderingKeyConceptSection()
            .padding()
    }
}
