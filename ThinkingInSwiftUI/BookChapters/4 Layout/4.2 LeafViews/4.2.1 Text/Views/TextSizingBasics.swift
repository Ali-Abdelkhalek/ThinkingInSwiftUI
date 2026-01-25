//
//  TextSizingBasics.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Text - Sizing Basics
//

import SwiftUI

struct TextSizingBasicsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Text Sizing Basics")
                    .font(.title)
                    .bold()

                howTextFitsSection
                examplesSection
                wrappingOrderSection
                liveExampleSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var howTextFitsSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("How Text Fits Into Proposed Size")
                    .font(.headline)

                Text("""
                By default, Text views fit themselves into ANY proposed size using these strategies (in order):

                1. Word wrapping (break lines between words)
                2. Line wrapping (break up words)
                3. Truncation (add ...)
                4. Clipping (cut off text)

                Text ALWAYS reports the exact size it needs, which is ≤ proposed width, and at least the height of one line (except when proposed 0×0).

                In other words: Text can become any width from zero to its ideal size.
                """)
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var examplesSection: some View {
        GroupBox("Examples: Same Text, Different Proposals") {
            VStack(spacing: 20) {
                // Narrow proposal
                VStack(alignment: .leading, spacing: 5) {
                    Text("Proposed: 25×50")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("Hello, World!")
                        .frame(width: 25, height: 50)
                        .border(Color.red, width: 2)

                    Text("Word wraps to fit")
                        .font(.caption2)
                        .foregroundColor(.green)
                }

                // Medium proposal
                VStack(alignment: .leading, spacing: 5) {
                    Text("Proposed: 50×50")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("Hello, World!")
                        .frame(width: 50, height: 50)
                        .border(Color.orange, width: 2)

                    Text("Fits on one line")
                        .font(.caption2)
                        .foregroundColor(.green)
                }

                // Wide proposal
                VStack(alignment: .leading, spacing: 5) {
                    Text("Proposed: 100×50")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("Hello, World!")
                        .frame(width: 100, height: 50)
                        .border(Color.blue, width: 2)

                    Text("Plenty of space")
                        .font(.caption2)
                        .foregroundColor(.green)
                }
            }
            .padding()
        }
    }

    private var wrappingOrderSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Text Wrapping Order")
                    .font(.headline)

                Text("""
                Text tries these strategies sequentially:

                1️⃣ Word Wrapping
                   Break between words: "Hello, World!" → "Hello,\\nWorld!"

                2️⃣ Line Wrapping
                   Break words: "Supercalifragilisticexpialidocious"
                              → "Supercalifragi-\\nlisticexpialid-\\nocious"

                3️⃣ Truncation
                   Add ellipsis: "Hello, World!" → "Hell..."

                4️⃣ Clipping
                   Cut off: "Hello, World!" → "Hell" (no ...)
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var liveExampleSection: some View {
        GroupBox("Live Example: Long Text") {
            VStack(spacing: 15) {
                Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works.")
                    .padding()
                    .border(Color.black, width: 2)

                Text("No constraints → Natural size with word wrapping")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
    }
}

#Preview {
    TextSizingBasicsView()
}
