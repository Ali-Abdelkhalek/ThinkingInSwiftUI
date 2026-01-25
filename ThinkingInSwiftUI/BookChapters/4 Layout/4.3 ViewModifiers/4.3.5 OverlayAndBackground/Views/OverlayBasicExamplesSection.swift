//
//  OverlayBasicExamplesSection.swift
//  ThinkingInSwiftUI
//
//  Basic examples of overlay and background usage
//

import SwiftUI

struct OverlayBasicExamplesSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Background - Behind Primary",
                description: "Secondary draws behind",
                code: "Text(\"Hello\").background(Color.teal)"
            ) {
                VStack(spacing: 12) {
                    Text("Hello")
                        .background(Color.teal)
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Text is primary (on top)")
                        Text("• Color is secondary (behind)")
                        Text("• Red border shows the size")
                        Text("• Background is exactly text size")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Overlay - On Top of Primary",
                description: "Secondary draws on top",
                code: "Text(\"Hello\").overlay(Color.red.opacity(0.3))"
            ) {
                VStack(spacing: 12) {
                    Text("Hello")
                        .overlay(Color.red.opacity(0.3))
                        .border(Color.blue, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Text is primary (behind)")
                        Text("• Color is secondary (on top)")
                        Text("• Blue border shows the size")
                        Text("• Overlay is exactly text size")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Both Together",
                description: "Layering order demonstration",
                code: ".background(Color.teal).overlay(Color.red.opacity(0.3))"
            ) {
                VStack(spacing: 12) {
                    Text("Hello")
                        .background(Color.teal)
                        .overlay(Color.red.opacity(0.3))
                        .border(Color.purple, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Layer order (bottom to top):")
                            .fontWeight(.semibold)
                        Text("1️⃣ Teal (background)")
                        Text("2️⃣ Text (primary)")
                        Text("3️⃣ Red overlay (overlay)")
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
        OverlayBasicExamplesSection()
            .padding()
    }
}
