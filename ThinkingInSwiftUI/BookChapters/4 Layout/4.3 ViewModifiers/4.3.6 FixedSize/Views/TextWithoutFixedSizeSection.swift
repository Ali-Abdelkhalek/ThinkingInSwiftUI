//
//  TextWithoutFixedSizeSection.swift
//  ThinkingInSwiftUI
//
//  Shows how text behaves without fixedSize()
//

import SwiftUI

struct TextWithoutFixedSizeSection: View {
    var body: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Text Adapts to Proposed Size",
                description: "Text wraps or truncates to fit",
                code: "Text(\"This is a longer text\").frame(width: 50)"
            ) {
                VStack(spacing: 16) {
                    // 25pt width
                    VStack(spacing: 8) {
                        Text("Width: 25pt")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .frame(width: 25)
                            .background(Color.blue.opacity(0.2))
                            .border(Color.blue, width: 2)

                        Text("Wraps to multiple lines")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    // 50pt width
                    VStack(spacing: 8) {
                        Text("Width: 50pt")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .frame(width: 50)
                            .background(Color.green.opacity(0.2))
                            .border(Color.green, width: 2)

                        Text("Still wraps, fewer lines")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    // 100pt width
                    VStack(spacing: 8) {
                        Text("Width: 100pt")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .frame(width: 100)
                            .background(Color.orange.opacity(0.2))
                            .border(Color.orange, width: 2)

                        Text("Wraps or fits on fewer lines")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Text("Text does ANYTHING to fit: wrapping, truncation, etc.")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        TextWithoutFixedSizeSection()
            .padding()
    }
}
