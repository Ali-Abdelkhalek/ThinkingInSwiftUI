//
//  GridModifiersExample.swift
//  ThinkingInSwiftUI
//
//  Grid Modifiers - Cell-Specific Modifiers
//

import SwiftUI

struct GridModifiersExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Grid Cell Modifiers")
                    .font(.title)
                    .bold()

                // MARK: - Overview

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🛠️ Grid Cell Modifiers")
                            .font(.headline)

                        Text("SwiftUI provides 4 Grid-specific modifiers for customizing cell behavior:")
                            .font(.subheadline)

                        VStack(alignment: .leading, spacing: 12) {
                            ModifierDescription(
                                number: "1",
                                name: ".gridCellColumns(_:)",
                                description: "Spans a cell across multiple columns",
                                color: .blue
                            )

                            ModifierDescription(
                                number: "2",
                                name: ".gridColumnAlignment(_:)",
                                description: "Sets alignment for entire column",
                                color: .green
                            )

                            ModifierDescription(
                                number: "3",
                                name: ".gridCellUnsizedAxes(_:)",
                                description: "Uses ideal size instead of proposed size on specified axes",
                                color: .orange
                            )

                            ModifierDescription(
                                number: "4",
                                name: ".gridCellAnchor(_:)",
                                description: "Positions content within cell (like .frame(alignment:))",
                                color: .purple
                            )
                        }
                    }
                })

                // MARK: - 1. gridCellColumns

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("1️⃣ .gridCellColumns(_:)")
                            .font(.headline)
                            .foregroundColor(.blue)

                        Text("Make a cell span multiple columns (like HTML colspan):")
                            .font(.subheadline)

                        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Text("Header Spanning 3 Columns")
                                    .gridCellColumns(3)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.blue.opacity(0.3))
                            }

                            GridRow {
                                Text("A")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.green.opacity(0.3))
                                Text("B")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.orange.opacity(0.3))
                                Text("C")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.purple.opacity(0.3))
                            }
                            .frame(height: 60)

                            GridRow {
                                Text("D spans 2")
                                    .gridCellColumns(2)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.red.opacity(0.3))
                                Text("E")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.purple.opacity(0.3))
                            }
                            .frame(height: 60)
                        }

                        Text("Code example:")
                            .font(.caption)
                            .padding(.top, 4)

                        Text("""
                        Text("Header")
                            .gridCellColumns(3)  // Spans 3 columns
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

                // MARK: - 2. gridColumnAlignment

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("2️⃣ .gridColumnAlignment(_:)")
                            .font(.headline)
                            .foregroundColor(.green)

                        Text("Set alignment for an ENTIRE column (affects all cells in that column):")
                            .font(.subheadline)

                        Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Text("Leading")
                                    .gridColumnAlignment(.leading)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("Center")
                                    .gridColumnAlignment(.center)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("Trailing")
                                    .gridColumnAlignment(.trailing)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            GridRow {
                                Text("A")
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                Text("B")
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                                Text("C")
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))
                            }
                            .frame(height: 50)

                            GridRow {
                                Text("Very Long A")
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                Text("Short B")
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                                Text("Medium C")
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))
                            }
                            .frame(height: 50)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))

                        Text("⚠️ Important: Set on FIRST row to affect entire column")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                })

                // MARK: - 3. gridCellUnsizedAxes

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("3️⃣ .gridCellUnsizedAxes(_:)")
                            .font(.headline)
                            .foregroundColor(.orange)

                        Text("Tell Grid to use ideal size instead of proposed size on specific axes:")
                            .font(.subheadline)

                        Text("Options: .horizontal, .vertical, [.horizontal, .vertical]")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Text("Default behavior")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                Text("Default")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }

                            GridRow {
                                Text("Unsized horizontal")
                                    .gridCellUnsizedAxes(.horizontal)
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))
                                Text("Short")
                                    .gridCellUnsizedAxes(.horizontal)
                                    .padding(8)
                                    .background(Color.purple.opacity(0.2))
                            }
                        }
                        .border(Color.gray)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Row 1: Both cells accept proposed width (equal widths)")
                                .font(.caption2)
                            Text("Row 2: .gridCellUnsizedAxes(.horizontal) = use ideal width")
                                .font(.caption2)
                            Text("  → Column widths determined by content in Row 2")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }

                        Text("💡 .gridCellUnsizedAxes(.horizontal) is similar to .fixedSize()")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 4)
                    }
                })

                // MARK: - 4. gridCellAnchor

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("4️⃣ .gridCellAnchor(_:)")
                            .font(.headline)
                            .foregroundColor(.purple)

                        Text("Position content within its cell (like .frame(alignment:)):")
                            .font(.subheadline)

                        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Text("Top Leading")
                                    .gridCellAnchor(.topLeading)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    .background(Color.gray.opacity(0.1))

                                Text("Center")
                                    .gridCellAnchor(.center)
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .background(Color.gray.opacity(0.1))

                                Text("Bottom Trailing")
                                    .gridCellAnchor(.bottomTrailing)
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                    .background(Color.gray.opacity(0.1))
                            }
                            .frame(height: 80)
                        }
                        .border(Color.gray)

                        Text("Available anchors: .topLeading, .top, .topTrailing, .leading, .center, .trailing, .bottomLeading, .bottom, .bottomTrailing")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    GridModifiersExample()
}
