//
//  GridLayoutAlgorithm.swift
//  ThinkingInSwiftUI
//
//  Grid Layout Algorithm - Two-Pass Algorithm
//

import SwiftUI

struct GridLayoutAlgorithm: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Grid's Two-Pass Algorithm")
                    .font(.title)
                    .bold()

                // MARK: - Rows Are NOT Independent

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("⚠️ Rows are NOT Independent!")
                            .font(.headline)
                            .bold()

                        Text("Grid coordinates ALL rows together:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("✓ Analyzes ALL rows to determine column structure")
                                .font(.caption2)
                            Text("✓ Each column width = widest cell in that column across ALL rows")
                                .font(.caption2)
                            Text("✓ All rows align to the same column positions")
                                .font(.caption2)
                            Text("✗ Rows are NOT independent like separate HStacks")
                                .font(.caption2)
                        }

                        Text("Example: Wide cell in Row 1 affects ALL rows")
                            .font(.caption)
                            .padding(.top, 8)

                        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Text("Very Long Text Here")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                Text("B")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }

                            GridRow {
                                Text("A")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                Text("B")
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }
                        }
                        .border(Color.gray)

                        Text("↑ Column 1 width determined by 'Very Long Text Here' - affects BOTH rows!")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                })

                // MARK: - Two-Pass Algorithm

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📐 Grid's Two-Pass Algorithm")
                            .font(.headline)
                            .bold()

                        Text("Unlike HStack/VStack, Grid goes through column layout TWICE:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 10) {
                            LayoutStep(
                                step: "1",
                                title: "Layout Pass",
                                description: "Grid uses proposed width to determine column widths and row heights"
                            )

                            LayoutStep(
                                step: "2",
                                title: "Render Pass",
                                description: "Grid uses calculated width from layout pass and divides it among columns AGAIN"
                            )
                        }

                        Text("This two-pass approach allows Grid to handle flexible views like Text that wrap!")
                            .font(.caption)
                            .foregroundColor(.green)
                            .padding(.top, 8)
                    }
                })

                // MARK: - Example with Rectangles

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example with Fixed Rectangles")
                            .font(.headline)

                        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Rectangle()
                                    .fill(Color.blue.opacity(0.3))
                                    .frame(width: 150, height: 60)
                                    .overlay(Text("150×60").font(.caption2))
                                Rectangle()
                                    .fill(Color.green.opacity(0.3))
                                    .frame(width: 50, height: 70)
                                    .overlay(Text("50×70").font(.caption2))
                            }

                            GridRow {
                                Rectangle()
                                    .fill(Color.blue.opacity(0.3))
                                    .frame(width: 50, height: 50)
                                    .overlay(Text("50×50").font(.caption2))
                                Rectangle()
                                    .fill(Color.green.opacity(0.3))
                                    .frame(width: 80, height: 40)
                                    .overlay(Text("80×40").font(.caption2))
                            }
                        }
                        .border(Color.gray)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Column widths: [max(150,50)=150, max(50,80)=80]")
                                .font(.caption2)
                                .foregroundColor(.blue)
                            Text("Row heights: [max(60,70)=70, max(50,40)=50]")
                                .font(.caption2)
                                .foregroundColor(.green)
                            Text("Final Grid size: 230×120 (excluding spacing)")
                                .font(.caption2)
                                .bold()
                        }

                        Text("Key insight: Column widths are coordinated across ALL rows (max of each column), then Grid does a second pass to finalize layout.")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 8)
                    }
                })

                // MARK: - Text Wrapping Example

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📝 Real Example: Text Wrapping")
                            .font(.headline)

                        Text("Now let's tackle the REAL scenario with wrapping text:")
                            .font(.caption)

                        MeasuredTextGrid()

                        Text("🎯 The two-pass algorithm ensures:")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("• Grid defaults to EQUAL-WIDTH FLEXIBLE columns")
                                .font(.caption2)
                                .foregroundColor(.blue)
                                .bold()
                            Text("• Pass 1: Determine ideal column widths across all rows")
                                .font(.caption2)
                            Text("• Pass 2: Re-layout with those widths, allowing text to wrap if needed")
                                .font(.caption2)
                            Text("• Row heights can adjust in Pass 2 based on actual wrapped content")
                                .font(.caption2)
                            Text("• All cells in same column get SAME width (coordination!)")
                                .font(.caption2)
                                .foregroundColor(.orange)
                            Text("• Unlike LazyVGrid (uses GridItem), Grid has no explicit sizing")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    GridLayoutAlgorithm()
}
