//
//  FixedSizeWithText.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Text - fixedSize
//

import SwiftUI

struct FixedSizeWithTextView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("fixedSize with Text")
                    .font(.title)
                    .bold()

                whatFixedSizeDoesSection
                examplesSection
                directionalFixedSizeSection
                directionalExamplesSection
                commonUseCaseSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var whatFixedSizeDoesSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("What .fixedSize() Does")
                    .font(.headline)

                Text("""
                .fixedSize() proposes nil×nil to its subview.

                For Text, this means:
                "Become your IDEAL SIZE"

                Ideal size for Text = Size needed to render content WITHOUT wrapping or truncation.
                """)
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var examplesSection: some View {
        GroupBox("Example: Text with fixedSize()") {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Proposed: 25×50, no fixedSize")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("Hello, World!")
                        .frame(width: 25, height: 50)
                        .border(Color.blue, width: 2)

                    Text("Wraps to fit in 25pt")
                        .font(.caption2)
                        .foregroundColor(.blue)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text("Proposed: 25×50, WITH fixedSize")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("Hello, World!")
                        .fixedSize()
                        .frame(width: 25, height: 50)
                        .border(Color.red, width: 2)

                    Text("Ignores proposal, renders at ideal size (draws OUT OF BOUNDS!)")
                        .font(.caption2)
                        .foregroundColor(.red)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text("Proposed: 100×50, WITH fixedSize")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("Hello, World!")
                        .fixedSize()
                        .frame(width: 100, height: 50)
                        .border(Color.green, width: 2)

                    Text("Still ideal size, fits within bounds")
                        .font(.caption2)
                        .foregroundColor(.green)
                }
            }
            .padding()
        }
    }

    private var directionalFixedSizeSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text(".fixedSize(horizontal:vertical:)")
                    .font(.headline)

                Text("""
                Control which dimension becomes ideal size:

                .fixedSize(horizontal: true, vertical: false)
                → Width becomes ideal, height still wraps

                .fixedSize(horizontal: false, vertical: true)
                → Height becomes ideal, width still wraps
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var directionalExamplesSection: some View {
        GroupBox("Directional fixedSize Example") {
            VStack(spacing: 15) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(".fixedSize(horizontal: false, vertical: true)")
                        .font(.caption)
                        .bold()

                    Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works.")
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                        .border(Color.black, width: 2)

                    Text("Width wraps, height at ideal (no line limit)")
                        .font(.caption2)
                        .foregroundColor(.green)
                }
            }
            .padding()
        }
    }

    private var commonUseCaseSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Common Use Case")
                    .font(.headline)

                Text("""
                Text will do ANYTHING to fit into proposed size (truncation, wrapping, etc.).

                Sometimes you want to PREVENT this:

                Text("Important Label")
                    .fixedSize()

                Now it won't truncate or wrap, even if space is limited.

                ⚠️ Warning: Can cause overflow if there's not enough space!
                """)
                .font(.caption)
                .padding(8)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }
}

#Preview {
    FixedSizeWithTextView()
}
