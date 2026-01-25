//
//  LineLimit.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Leaf Views - Text - lineLimit & reservesSpace
//

import SwiftUI

struct LineLimitView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("lineLimit & reservesSpace")
                    .font(.title)
                    .bold()

                lineLimitBasicsSection
                lineLimitExamplesSection
                reservesSpaceBasicsSection
                reservesSpaceExamplesSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var lineLimitBasicsSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text(".lineLimit(_ number:)")
                    .font(.headline)

                Text("""
                Limits the maximum number of lines that should be rendered, regardless of whether there's more vertical space.

                .lineLimit(nil) → No limit (default for most contexts)
                .lineLimit(1) → Single line (truncates rest)
                .lineLimit(3) → Maximum 3 lines
                """)
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var lineLimitExamplesSection: some View {
        GroupBox("Examples") {
            VStack(spacing: 20) {
                // No line limit
                VStack(alignment: .leading, spacing: 5) {
                    Text("No lineLimit (default)")
                        .font(.caption)
                        .bold()

                    Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail.")
                        .padding()
                        .border(Color.black, width: 2)

                    Text("Word wraps naturally")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                // lineLimit 3
                VStack(alignment: .leading, spacing: 5) {
                    Text(".lineLimit(3)")
                        .font(.caption)
                        .bold()

                    Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works. We explain the most important concepts in detail.")
                        .lineLimit(3)
                        .padding()
                        .border(Color.black, width: 2)

                    Text("Truncates after 3 lines")
                        .font(.caption2)
                        .foregroundColor(.orange)
                }

                // lineLimit 1
                VStack(alignment: .leading, spacing: 5) {
                    Text(".lineLimit(1)")
                        .font(.caption)
                        .bold()

                    Text("SwiftUI is radically different from UIKit. In this short book, we will help you build a mental model of how SwiftUI works.")
                        .lineLimit(1)
                        .padding()
                        .border(Color.black, width: 2)

                    Text("Single line, rest truncated")
                        .font(.caption2)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
    }

    private var reservesSpaceBasicsSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text(".lineLimit(_ limit:reservesSpace:)")
                    .font(.headline)

                Text("""
                New API: Reserves space for specified lines even if they're empty.

                Useful for:
                • Consistent layout (all cells same height in list)
                • Preventing layout jumps when content changes
                • Placeholder text areas
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var reservesSpaceExamplesSection: some View {
        GroupBox("reservesSpace Example") {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(".lineLimit(7, reservesSpace: false)")
                        .font(.caption)
                        .bold()

                    Text("Short text")
                        .lineLimit(7, reservesSpace: false)
                        .padding()
                        .border(Color.black, width: 2)
                        .background(Color.gray.opacity(0.1))

                    Text("Only reserves space for actual content")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(".lineLimit(7, reservesSpace: true)")
                        .font(.caption)
                        .bold()

                    Text("Short text")
                        .lineLimit(7, reservesSpace: true)
                        .padding()
                        .border(Color.black, width: 2)
                        .background(Color.gray.opacity(0.1))

                    Text("Reserves space for all 7 lines!")
                        .font(.caption2)
                        .foregroundColor(.orange)
                }
            }
            .padding()
        }
    }
}

#Preview {
    LineLimitView()
}
