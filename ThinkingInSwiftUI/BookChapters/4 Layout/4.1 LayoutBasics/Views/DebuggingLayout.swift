//
//  DebuggingLayout.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Debugging Layout
//

import SwiftUI

struct DebuggingLayoutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 30) {
                Text("Debugging Layout")
                    .font(.title)
                    .bold()

                bordersSection
                geometryReaderSection
                viewTreesSection
                commonPatternsSection
            }
            .padding()
        }
    }

    // MARK: - Sections

    private var bordersSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Best Method: Borders")
                    .font(.headline)

                Text("""
                Adding .border() is the #1 way to debug layout issues!

                It shows the actual size and position of a view.
                """)
                .font(.caption)
                .padding(8)
                .background(Color.green.opacity(0.1))
                .cornerRadius(5)

                VStack(spacing: 15) {
                    Text("Without border:")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Hello")
                        .padding()
                        .background(Color.teal)

                    Text("With border:")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Hello")
                        .padding()
                        .background(Color.teal)
                        .border(Color.red, width: 2)

                    Text("Now you can see the padding extends beyond the teal background!")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    private var geometryReaderSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("GeometryReader for Size")
                    .font(.headline)

                Text("""
                You can overlay a GeometryReader to show the size:

                Text("Hello")
                    .border(Color.red)
                    .overlay {
                        GeometryReader { proxy in
                            Text("\\(proxy.size.width) × \\(proxy.size.height)")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(2)
                                .background(Color.black.opacity(0.7))
                        }
                    }

                But borders are usually enough!
                """)
                .font(.caption)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var viewTreesSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Understanding View Trees")
                    .font(.headline)

                Text("""
                Remember: View modifiers wrap views!

                Text("Hello")
                    .padding()
                    .background(Color.teal)

                Creates this tree:

                background
                ├─ padding
                │  └─ Text
                └─ Color

                Layout proceeds TOP-DOWN through this tree.
                Understanding the tree helps predict layout behavior.
                """)
                .font(.caption)
                .padding(8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }

    private var commonPatternsSection: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 15) {
                Text("Common Debug Patterns")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Text("1. Add borders to see actual size")
                        .font(.caption)
                    Text("2. Use different border colors at different levels")
                        .font(.caption)
                    Text("3. Check if view is clipped (.clipped() modifier)")
                        .font(.caption)
                    Text("4. Verify spacing in stacks (.spacing parameter)")
                        .font(.caption)
                    Text("5. Look for competing frame modifiers")
                        .font(.caption)
                }
                .padding(8)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(5)
            }
        }
    }
}

#Preview {
    DebuggingLayoutView()
}
