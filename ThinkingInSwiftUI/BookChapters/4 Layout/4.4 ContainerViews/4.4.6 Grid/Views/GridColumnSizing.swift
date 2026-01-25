//
//  GridColumnSizing.swift
//  ThinkingInSwiftUI
//
//  Grid Column Sizing - Flexible, Fixed, and Adaptive Columns
//

import SwiftUI

struct GridColumnSizing: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Grid Column Sizing")
                    .font(.title)
                    .bold()

                // MARK: - Default Column Sizing

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📏 Default Column Sizing")
                            .font(.headline)
                            .foregroundColor(.blue)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Grid creates EQUAL-WIDTH FLEXIBLE columns by default")
                                .font(.caption)
                                .bold()
                            Text("• Without explicit sizing, available width is divided equally")
                                .font(.caption)
                            Text("• This is different from LazyVGrid where you use GridItem")
                                .font(.caption)
                            Text("• LazyVGrid: GridItem(.fixed()), .flexible(), .adaptive()")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("• Grid: No GridItem - defaults to flexible equal widths")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }

                        Text("Example: 2 columns in Grid → each gets 50% of width")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(.top, 4)
                    }
                })

                // MARK: - Customizing Column Widths

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🎨 Customizing Column Widths")
                            .font(.headline)
                            .foregroundColor(.purple)

                        Text("Unlike LazyVGrid (where you define GridItem upfront), Grid uses CELL MODIFIERS:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• .frame(maxWidth: .infinity) → Flexible column (expands)")
                                .font(.caption2)
                            Text("• .frame(width: N) → Fixed width column")
                                .font(.caption2)
                            Text("• .fixedSize() → Content-sized column")
                                .font(.caption2)
                            Text("  (Grid finds MAX ideal width across all cells in column)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("• .gridCellUnsizedAxes(.horizontal) → Alternative to fixedSize")
                                .font(.caption2)
                        }

                        Text("Example: Column 1 flexible, Column 2 content-sized")
                            .font(.caption)
                            .padding(.top, 8)

                        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Text("Very Long Text in Flexible Column")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                Text("B")
                                    .fixedSize()
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }

                            GridRow {
                                Text("Also flexible")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                Text("B")
                                    .fixedSize()
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }
                        }
                        .border(Color.gray)

                        Text("↑ Column 1 expands, Column 2 width = max('B', 'B') = natural 'B' width")
                            .font(.caption2)
                            .foregroundColor(.purple)
                    }
                })

                // MARK: - Mixed Column Types

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Mixed Column Types")
                            .font(.headline)

                        Text("Mix flexible, fixed, and adaptive columns:")
                            .font(.subheadline)

                        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Text("Label:")
                                    .fixedSize()
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))

                                Text("This is flexible content that expands")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))

                                Image(systemName: "star.fill")
                                    .fixedSize()
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }

                            GridRow {
                                Text("Name:")
                                    .fixedSize()
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))

                                Text("Short text")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))

                                Image(systemName: "checkmark")
                                    .fixedSize()
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }

                            GridRow {
                                Text("Description:")
                                    .fixedSize()
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))

                                Text("Another flexible column that takes remaining space")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))

                                Image(systemName: "heart.fill")
                                    .fixedSize()
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }
                        }
                        .border(Color.gray)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Column behaviors:")
                                .font(.caption)
                                .bold()
                            Text("• Column 1 (orange): ALL cells have .fixedSize()")
                                .font(.caption2)
                            Text("  → Grid takes MAX → Column width = widest label for ALL cells")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("• Column 2 (blue): ALL cells have .frame(maxWidth: .infinity)")
                                .font(.caption2)
                            Text("  → Flexible - takes remaining space after columns 1 & 3")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("• Column 3 (green): ALL cells have .fixedSize()")
                                .font(.caption2)
                            Text("  → Grid takes MAX of all icon widths")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }

                        Text("💡 Key insight: Grid coordinates column widths - each column gets ONE width (the max of all cells in that column)")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 4)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    GridColumnSizing()
}
