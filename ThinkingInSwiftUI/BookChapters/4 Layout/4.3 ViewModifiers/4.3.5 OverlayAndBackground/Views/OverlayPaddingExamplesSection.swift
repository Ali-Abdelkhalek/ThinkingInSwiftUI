//
//  OverlayPaddingExamplesSection.swift
//  ThinkingInSwiftUI
//
//  Examples showing how padding interacts with overlay and background
//

import SwiftUI

struct OverlayPaddingExamplesSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Background Adapts to Padding",
                description: "Secondary receives padded size",
                code: "Text(\"Hello\").padding(10).background(Color.teal)"
            ) {
                VStack(spacing: 12) {
                    Text("Hello")
                        .padding(10)
                        .background(Color.teal)
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Process:")
                            .fontWeight(.semibold)
                        Text("1. Text reports ~44×17")
                        Text("2. Padding adds 10pts each side → 64×37")
                        Text("3. Background proposed 64×37")
                        Text("4. Background becomes 64×37")
                        Text("5. Background reports 64×37")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Order Matters!",
                description: "Padding position affects background size",
                code: ""
            ) {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Padding BEFORE background:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("Hello")
                            .padding(10)
                            .background(Color.teal)
                            .border(Color.red, width: 2)

                        Text("Background includes padding")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Padding AFTER background:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("Hello")
                            .background(Color.teal)
                            .padding(10)
                            .border(Color.red, width: 2)

                        Text("Background only around text")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }

            exampleCard(
                title: "Negative Padding on Secondary",
                description: "Secondary can extend beyond primary",
                code: "Color.orange.padding(-3)"
            ) {
                VStack(spacing: 12) {
                    Text("Hello")
                        .background {
                            Color.orange
                                .padding(-3)
                        }
                        .border(Color.blue, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Text size: ~44×17 (blue border)")
                        Text("• Background proposed: 44×17")
                        Text("• Background applies padding(-3)")
                        Text("• Background becomes: 50×23")
                        Text("• But reported size stays 44×17!")
                        Text("• Orange bleeds beyond border")
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
        OverlayPaddingExamplesSection()
            .padding()
    }
}
