//
//  OverlayMultipleViewsSection.swift
//  ThinkingInSwiftUI
//
//  Shows how multiple views in background/overlay create implicit ZStack
//

import SwiftUI

struct OverlayMultipleViewsSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Multiple Views = Implicit ZStack",
                description: "Secondary view can contain multiple views",
                code: ""
            ) {
                VStack(spacing: 16) {
                    Text("Hello")
                        .background {
                            Color.teal
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .padding(5)
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Code:")
                            .fontWeight(.semibold)

                        Text("""
                        .background {
                            Color.teal
                            Circle().stroke()
                        }
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)

                        Text("Multiple views wrapped in implicit ZStack")
                            .foregroundColor(.secondary)
                    }
                    .font(.caption)
                }
            }

            exampleCard(
                title: "Layering with Multiple Views",
                description: "Order determines drawing order",
                code: ""
            ) {
                VStack(spacing: 12) {
                    Text("Layered")
                        .foregroundColor(.white)
                        .background {
                            Color.blue
                            Circle()
                                .fill(Color.red)
                                .padding(10)
                            Rectangle()
                                .stroke(Color.yellow, lineWidth: 3)
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Drawing order (back to front):")
                            .fontWeight(.semibold)
                        Text("1️⃣ Blue color (first in background)")
                        Text("2️⃣ Red circle (second)")
                        Text("3️⃣ Yellow border (third)")
                        Text("4️⃣ Text \"Layered\" (primary, on top)")
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
        OverlayMultipleViewsSection()
            .padding()
    }
}
