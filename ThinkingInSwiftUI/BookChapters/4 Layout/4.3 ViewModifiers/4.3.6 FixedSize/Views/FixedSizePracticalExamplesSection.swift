//
//  FixedSizePracticalExamplesSection.swift
//  ThinkingInSwiftUI
//
//  Practical real-world examples of fixedSize() usage
//

import SwiftUI

struct FixedSizePracticalExamplesSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Button with Full-Width Text",
                description: "Prevent text truncation in buttons",
                code: ""
            ) {
                VStack(spacing: 12) {
                    VStack(spacing: 8) {
                        Text("Without fixedSize:")
                            .font(.caption)

                        Button("Very Long Button Title Here") {}
                            .buttonStyle(.borderedProminent)
                            .frame(width: 150)

                        Text("Text truncates")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    VStack(spacing: 8) {
                        Text("With fixedSize:")
                            .font(.caption)

                        Button("Very Long Button Title Here") {}
                            .buttonStyle(.borderedProminent)
                            .fixedSize()

                        Text("Button expands to fit text")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }

            exampleCard(
                title: "Multi-line Text with Fixed Width",
                description: "Height adapts to content, width constrained",
                code: "fixedSize(horizontal: false, vertical: true)"
            ) {
                VStack(spacing: 12) {
                    Text("This is a longer text that should wrap to multiple lines based on the width constraint but grow vertically to show all content")
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: 200)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)

                    Text("Width: 200pt (constrained)\nHeight: grows to fit all lines")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }

            exampleCard(
                title: "Horizontal Scrolling Text",
                description: "Text doesn't wrap, can scroll horizontally",
                code: "fixedSize(horizontal: true, vertical: false)"
            ) {
                VStack(spacing: 12) {
                    ScrollView(.horizontal) {
                        Text("This is a very long text that will not wrap and can be scrolled horizontally to see the full content")
                            .fixedSize(horizontal: true, vertical: false)
                            .padding()
                            .background(Color.green.opacity(0.2))
                    }
                    .frame(height: 60)
                    .border(Color.green, width: 2)

                    Text("Text doesn't wrap, scroll to see all →")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        FixedSizePracticalExamplesSection()
            .padding()
    }
}
