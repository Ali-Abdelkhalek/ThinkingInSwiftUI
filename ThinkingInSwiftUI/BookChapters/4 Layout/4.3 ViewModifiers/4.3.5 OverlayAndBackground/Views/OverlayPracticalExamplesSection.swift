//
//  OverlayPracticalExamplesSection.swift
//  ThinkingInSwiftUI
//
//  Practical real-world examples of overlay and background usage
//

import SwiftUI

struct OverlayPracticalExamplesSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "The highlight() Modifier",
                description: "From the book - doesn't affect sibling layout",
                code: ""
            ) {
                VStack(spacing: 12) {
                    HStack {
                        Text("Normal")
                            .highlight(enabled: false)

                        Text("Highlighted")
                            .highlight(enabled: true)

                        Text("Normal")
                            .highlight(enabled: false)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Implementation:")
                            .fontWeight(.semibold)

                        Text("""
                        func highlight(enabled: Bool = true) -> some View {
                            background {
                                if enabled {
                                    Color.orange.padding(-3)
                                }
                            }
                        }
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)

                        Text("Notice: All three texts stay in the same position! The orange background bleeds but doesn't affect layout.")
                            .foregroundColor(.orange)
                    }
                    .font(.caption)
                }
            }

            exampleCard(
                title: "Badge with Overlay",
                description: "Number badge in corner",
                code: ""
            ) {
                VStack(spacing: 12) {
                    Text("Messages")
                        .font(.title3)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .overlay(alignment: .topTrailing) {
                            Text("5")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 8, y: -8)
                        }

                    Text("Badge is in overlay, doesn't affect button size")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Border with Background",
                description: "Custom border effect",
                code: ""
            ) {
                VStack(spacing: 12) {
                    Text("Custom Border")
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    LinearGradient(
                                        colors: [.blue, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 3
                                )
                        }

                    Text("Gradient border using background")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        OverlayPracticalExamplesSection()
            .padding()
    }
}
