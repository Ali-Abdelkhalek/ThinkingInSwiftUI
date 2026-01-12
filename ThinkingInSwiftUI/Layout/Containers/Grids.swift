//
//  Grids.swift
//  ThinkingInSwiftUI
//
//  Understanding Grid, LazyVGrid, and LazyHGrid
//

import SwiftUI

// MARK: - Grid Concepts
//
// SwiftUI has THREE types of grids:
//
// 1. Grid (iOS 16+)
//    - Two-dimensional grid layout
//    - Non-lazy (all cells created immediately)
//    - Cells can span multiple rows/columns
//    - Aligns content across rows AND columns
//    - Note: The book mentions Grid was unstable/buggy in iOS 16-17
//
// 2. LazyVGrid (iOS 14+)
//    - VERTICAL scrolling grid (columns are fixed, rows grow)
//    - Lazy loading (cells created as needed)
//    - Single-axis layout
//    - Better for large datasets
//
// 3. LazyHGrid (iOS 14+)
//    - HORIZONTAL scrolling grid (rows are fixed, columns grow)
//    - Lazy loading (cells created as needed)
//    - Single-axis layout
//    - Better for large datasets

// MARK: - Why Grids? The Problem They Solve

struct WhyGridsExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Why Do We Need Grids?")
                    .font(.title)
                    .bold()

                // MARK: - UIKit Comparison

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("📱 The UIKit Connection")
                            .font(.headline)

                        Text("In UIKit, we had UICollectionView for grid layouts:")
                            .font(.subheadline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• UICollectionView = powerful, flexible grid system")
                                .font(.caption)
                            Text("• UICollectionViewFlowLayout = most common (grid/list)")
                                .font(.caption)
                            Text("• Lazy loading built-in (cells created on demand)")
                                .font(.caption)
                            Text("• Perfect for photos, products, custom grids")
                                .font(.caption)
                        }

                        Text("SwiftUI's equivalent:")
                            .font(.subheadline)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top, spacing: 8) {
                                Text("→")
                                    .foregroundColor(.blue)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("LazyVGrid/LazyHGrid")
                                        .font(.caption)
                                        .bold()
                                    Text("= UICollectionView with flow layout")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    Text("Lazy loading, flexible columns, scrolling")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                            }

                            HStack(alignment: .top, spacing: 8) {
                                Text("→")
                                    .foregroundColor(.green)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Grid")
                                        .font(.caption)
                                        .bold()
                                    Text("= Small 2D tables/forms")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    Text("Non-lazy, cell spanning, precise alignment")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }

                        Text("💡 Key insight: LazyVGrid/LazyHGrid are SwiftUI's answer to UICollectionView - use them for the same scenarios (photos, products, large datasets).")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 8)
                    }
                })

                // MARK: - Problem: Using Stacks

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("❌ Problem: Using VStack + HStack")
                            .font(.headline)

                        Text("Trying to create a grid with nested stacks:")
                            .font(.subheadline)

                        VStack(spacing: 10) {
                            HStack(spacing: 10) {
                                Text("A")
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue.opacity(0.3))
                                Text("Longer B")
                                    .frame(width: 60, height: 60)
                                    .background(Color.green.opacity(0.3))
                                Text("C")
                                    .frame(width: 60, height: 60)
                                    .background(Color.orange.opacity(0.3))
                            }

                            HStack(spacing: 10) {
                                Text("D")
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue.opacity(0.3))
                                Text("E")
                                    .frame(width: 60, height: 60)
                                    .background(Color.green.opacity(0.3))
                                Text("Very Long F")
                                    .frame(width: 60, height: 60)
                                    .background(Color.orange.opacity(0.3))
                            }
                        }

                        Text("⚠️ Issues:")
                            .font(.caption)
                            .bold()
                        Text("• Columns don't align across rows")
                            .font(.caption2)
                        Text("• Need fixed widths to make it work")
                            .font(.caption2)
                        Text("• Can't automatically size columns based on content")
                            .font(.caption2)
                    }
                })

                // MARK: - Solution: Grid

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("✅ Solution: Grid (iOS 16+)")
                            .font(.headline)

                        Text("Grid automatically aligns columns:")
                            .font(.subheadline)

                        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Text("A")
                                    .frame(height: 60)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.3))
                                Text("Longer B")
                                    .frame(height: 60)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green.opacity(0.3))
                                Text("C")
                                    .frame(height: 60)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange.opacity(0.3))
                            }

                            GridRow {
                                Text("D")
                                    .frame(height: 60)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.3))
                                Text("E")
                                    .frame(height: 60)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green.opacity(0.3))
                                Text("Very Long F")
                                    .frame(height: 60)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange.opacity(0.3))
                            }
                        }

                        Text("✓ Benefits:")
                            .font(.caption)
                            .bold()
                        Text("• Columns automatically align")
                            .font(.caption2)
                        Text("• Column width adapts to widest content")
                            .font(.caption2)
                        Text("• Rows align to tallest cell")
                            .font(.caption2)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - Grid (iOS 16+) Examples

struct GridExamples: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Grid (iOS 16+)")
                    .font(.title)
                    .bold()

                Text("⚠️ Note from 'Thinking in SwiftUI': Grid was considered unstable/buggy in iOS 16-17 (when the book was written). The book skipped it and focused on LazyVGrid/LazyHGrid instead.")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)

                // MARK: - How Grid Works

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("🔤 Grid is ROW-Oriented")
                            .font(.headline)

                        Text("Important: Grid uses GridRow, NOT GridColumn!")
                            .font(.subheadline)
                            .foregroundColor(.orange)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• You define ROWS using GridRow { }")
                                .font(.caption)
                            Text("• Columns are IMPLICIT (inferred from row contents)")
                                .font(.caption)
                            Text("• Grid automatically aligns columns across all rows")
                                .font(.caption)
                            Text("• NO GridColumn exists - columns emerge from structure")
                                .font(.caption)
                        }

                        Text("Example structure:")
                            .font(.subheadline)
                            .padding(.top, 8)

                        Text("""
                        Grid {
                            GridRow {  // Row 1
                                Text("A")  // → Column 1
                                Text("B")  // → Column 2
                                Text("C")  // → Column 3
                            }
                            GridRow {  // Row 2
                                Text("D")  // → Column 1 (auto-aligned with "A")
                                Text("E")  // → Column 2 (auto-aligned with "B")
                                Text("F")  // → Column 3 (auto-aligned with "C")
                            }
                        }
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                        
                        Grid {
                            GridRow {  // Row 1
                                Text("A")  // → Column 1
                                Text("B")  // → Column 2
                                Text("C")  // → Column 3
                            }
                            GridRow {  // Row 2
                                Text("D")  // → Column 1 (auto-aligned with "A")
                                Text("E")  // → Column 2 (auto-aligned with "B")
                                Text("F")  // → Column 3 (auto-aligned with "C")
                            }
                        }

                        Text("Grid sees 3 cells in each row → creates 3 columns automatically!")
                            .font(.caption)
                            .foregroundColor(.green)

                        Divider()
                            .padding(.vertical, 8)

                        Text("⚠️ Rows are NOT Independent!")
                            .font(.subheadline)
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

                        Divider()
                            .padding(.vertical, 8)

                        Text("📐 Grid's Two-Pass Algorithm")
                            .font(.subheadline)
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

                        Text("Example with Fixed Rectangles:")
                            .font(.caption)
                            .padding(.top, 8)

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
                            Text("Final Grid size: 230×120")
                                .font(.caption2)
                                .bold()
                        }

                        Text("Key insight: Column widths are coordinated across ALL rows (max of each column), then Grid does a second pass to finalize layout.")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 8)

                        Divider()
                            .padding(.vertical, 8)

                        Text("Detailed Step-by-Step (Two-Pass Algorithm)")
                            .font(.subheadline)
                            .bold()

                        VStack(alignment: .leading, spacing: 12) {
                            Text("PASS 1: LAYOUT PASS")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.blue)

                            LayoutStep(
                                step: "1",
                                title: "Grid receives proposal",
                                description: "Parent proposes, say, 300×∞ to Grid"
                            )

                            LayoutStep(
                                step: "2",
                                title: "Grid proposes to all cells",
                                description: """
                                Row 1, Col 1: Proposes 300×∞
                                Row 1, Col 2: Proposes 300×∞
                                Row 2, Col 1: Proposes 300×∞
                                Row 2, Col 2: Proposes 300×∞
                                (Same proposal to all cells)
                                """
                            )

                            LayoutStep(
                                step: "3",
                                title: "Cells report their sizes",
                                description: """
                                Row 1, Col 1: Reports 150×60 (blue rectangle)
                                Row 1, Col 2: Reports 50×70 (green rectangle)
                                Row 2, Col 1: Reports 50×50 (blue rectangle)
                                Row 2, Col 2: Reports 80×40 (green rectangle)
                                """
                            )

                            LayoutStep(
                                step: "4",
                                title: "Grid calculates column widths",
                                description: """
                                Column 1: max(150, 50) = 150
                                Column 2: max(50, 80) = 80
                                Total width: 150 + 80 = 230
                                """
                            )

                            LayoutStep(
                                step: "5",
                                title: "Grid calculates row heights",
                                description: """
                                Row 1: max(60, 70) = 70
                                Row 2: max(50, 40) = 50
                                Total height: 70 + 50 = 120
                                """
                            )

                            LayoutStep(
                                step: "6",
                                title: "Grid reports its size",
                                description: "Grid reports: 230×120 to parent"
                            )

                            Text("PASS 2: RENDER PASS")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.green)
                                .padding(.top, 8)

                            LayoutStep(
                                step: "7",
                                title: "Grid starts with calculated width",
                                description: "Grid now has 230pt width (from layout pass)"
                            )

                            LayoutStep(
                                step: "8",
                                title: "Grid re-proposes to cells with column/row sizes",
                                description: """
                                Row 1, Col 1: Proposes 150×70 (column 1 width × row 1 height)
                                Row 1, Col 2: Proposes 80×70 (column 2 width × row 1 height)
                                Row 2, Col 1: Proposes 150×50 (column 1 width × row 2 height)
                                Row 2, Col 2: Proposes 80×50 (column 2 width × row 2 height)
                                """
                            )

                            LayoutStep(
                                step: "9",
                                title: "Grid positions cells",
                                description: """
                                Row 1, Col 1: Position (0, 0), size 150×70
                                Row 1, Col 2: Position (150, 0), size 80×70
                                Row 2, Col 1: Position (0, 70), size 150×50
                                Row 2, Col 2: Position (150, 70), size 80×50
                                """
                            )

                            LayoutStep(
                                step: "✓",
                                title: "Layout complete!",
                                description: "All cells positioned with coordinated column widths and row heights"
                            )
                        }

                        Text("Note: Forgot spacing! With horizontalSpacing=10, verticalSpacing=10:")
                            .font(.caption2)
                            .foregroundColor(.orange)
                        Text("Total width = 150 + 10 + 80 = 240, Total height = 70 + 10 + 50 = 130")
                            .font(.caption2)
                            .foregroundColor(.orange)

                        Divider()
                            .padding(.vertical, 8)

                        Text("📝 Real Example: Text Wrapping")
                            .font(.subheadline)
                            .bold()

                        Text("Now let's tackle the REAL scenario with wrapping text:")
                            .font(.caption)

                        MeasuredTextGrid()

                        Text("The two-pass algorithm is ESSENTIAL for wrapping text:")
                            .font(.caption)
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Pass 1: Grid proposes wide size → Text reports ideal (single line)")
                                .font(.caption2)
                            Text("Pass 1: Grid calculates column widths from ideal sizes")
                                .font(.caption2)
                            Text("Pass 2: Grid re-proposes calculated column widths → Text WRAPS if needed")
                                .font(.caption2)
                            Text("Pass 2: Row heights adjust based on wrapped text height")
                                .font(.caption2)
                        }

                        Text("🎯 Without two passes, Grid couldn't coordinate wrapping text across rows!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 8)
                    }
                })

                // MARK: - Basic Grid

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Basic Grid Example")
                            .font(.headline)

                        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Color.blue
                                Color.green
                                Color.orange
                            }
                            .frame(height: 60)

                            GridRow {
                                Color.red
                                Color.purple
                                Color.pink
                            }
                            .frame(height: 60)
                        }

                        Text("2 rows × 3 columns (3 columns inferred from GridRow contents)")
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        Text("All cells created immediately (non-lazy)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })

                // MARK: - Cell Spanning

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Cell Spanning")
                            .font(.headline)

                        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Text("Header")
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
                        }

                        Text("Grid unique feature: cells can span multiple columns/rows")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })

                // MARK: - Alignment

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Column Alignment")
                            .font(.headline)

                        Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Text("Left")
                                    .gridColumnAlignment(.leading)
                                Text("Center")
                                    .gridColumnAlignment(.center)
                                Text("Right")
                                    .gridColumnAlignment(.trailing)
                            }
                            .font(.caption)
                            .foregroundColor(.secondary)

                            GridRow {
                                Text("A")
                                Text("B")
                                Text("C")
                            }
                            .frame(height: 50)

                            GridRow {
                                Text("Very Long A")
                                Text("Short B")
                                Text("Medium C")
                            }
                            .frame(height: 50)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))

                        Text("Each column can have its own alignment")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - LazyVGrid Examples

struct LazyVGridExamples: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("LazyVGrid (iOS 14+)")
                    .font(.title)
                    .bold()

                Text("VERTICAL scrolling grid with FIXED columns, GROWING rows")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // MARK: - Basic LazyVGrid

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Basic LazyVGrid - 3 Columns")
                            .font(.headline)

                        let columns = [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ]

                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(0..<30) { i in
                                    Text("\(i)")
                                        .frame(height: 60)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue.opacity(0.3))
                                        .cornerRadius(8)
                                }
                            }
                            .padding()
                        }
                        .frame(height: 300)

                        Text("Columns: Fixed (3) | Rows: Grow as needed")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })

                // MARK: - GridItem Types

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("GridItem Types")
                            .font(.headline)

                        Text("1. .flexible() - Shares available space")
                            .font(.subheadline)

                        let flexibleColumns = [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ]

                        LazyVGrid(columns: flexibleColumns, spacing: 10) {
                            ForEach(0..<6) { i in
                                Text("\(i)")
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green.opacity(0.3))
                            }
                        }

                        Divider()

                        Text("2. .fixed(width) - Fixed width columns")
                            .font(.subheadline)

                        let fixedColumns = [
                            GridItem(.fixed(100)),
                            GridItem(.fixed(150)),
                            GridItem(.fixed(80))
                        ]

                        LazyVGrid(columns: fixedColumns, spacing: 10) {
                            ForEach(0..<6) { i in
                                Text("\(i)")
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange.opacity(0.3))
                            }
                        }

                        Divider()

                        Text("3. .adaptive(minimum) - Fits as many as possible")
                            .font(.subheadline)

                        let adaptiveColumns = [
                            GridItem(.adaptive(minimum: 80))
                        ]

                        LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                            ForEach(0..<20) { i in
                                Text("\(i)")
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.purple.opacity(0.3))
                            }
                        }

                        Text("Adaptive creates as many columns as fit (try rotating device)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                })
            }
            .padding()
        }
    }
}

// MARK: - LazyHGrid Examples

struct LazyHGridExamples: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("LazyHGrid (iOS 14+)")
                .font(.title)
                .bold()
                .padding(.horizontal)

            Text("HORIZONTAL scrolling grid with FIXED rows, GROWING columns")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            // MARK: - Basic LazyHGrid

            GroupBox(label: EmptyView(), content: {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Basic LazyHGrid - 3 Rows")
                        .font(.headline)

                    let rows = [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]

                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows, spacing: 10) {
                            ForEach(0..<30) { i in
                                Text("\(i)")
                                    .frame(width: 80)
                                    .frame(maxHeight: .infinity)
                                    .background(Color.blue.opacity(0.3))
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                    }
                    .frame(height: 200)

                    Text("Rows: Fixed (3) | Columns: Grow as needed")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            })
            .padding(.horizontal)

            // MARK: - Comparison

            GroupBox(label: EmptyView(), content: {
                VStack(alignment: .leading, spacing: 10) {
                    Text("LazyVGrid vs LazyHGrid")
                        .font(.headline)

                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("LazyVGrid")
                                .font(.subheadline)
                                .bold()
                            Text("• Scrolls vertically ↓")
                                .font(.caption2)
                            Text("• Columns fixed")
                                .font(.caption2)
                            Text("• Rows grow")
                                .font(.caption2)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("LazyHGrid")
                                .font(.subheadline)
                                .bold()
                            Text("• Scrolls horizontally →")
                                .font(.caption2)
                            Text("• Rows fixed")
                                .font(.caption2)
                            Text("• Columns grow")
                                .font(.caption2)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            })
            .padding(.horizontal)

            Spacer()
        }
        .padding(.vertical)
    }
}

// MARK: - Lazy Loading Demo

struct LazyGridLoadingDemo: View {
    @State private var appearedCells: Set<Int> = []

    var body: some View {
        VStack(spacing: 20) {
            Text("Lazy Loading Demo")
                .font(.title)
                .bold()

            Text("Appeared: \(appearedCells.count) / 1000 cells")
                .font(.caption)
                .foregroundColor(.secondary)

            let columns = [
                GridItem(.adaptive(minimum: 80))
            ]

            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(0..<1000) { i in
                        VStack {
                            if appearedCells.contains(i) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.caption2)
                            }
                            Text("\(i)")
                        }
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                        .onAppear {
                            appearedCells.insert(i)
                        }
                        .onDisappear {
                            appearedCells.remove(i)
                        }
                    }
                }
                .padding()
            }

            Text("Only visible cells are created (scroll to see more)")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

// MARK: - Comprehensive Comparison

struct GridComparisonView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Grid Types Comparison")
                    .font(.title)
                    .bold()

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        GridComparisonRow(
                            feature: "Introduction",
                            grid: "iOS 16",
                            lazyVGrid: "iOS 14",
                            lazyHGrid: "iOS 14"
                        )

                        GridComparisonRow(
                            feature: "Dimensions",
                            grid: "2D (rows & columns)",
                            lazyVGrid: "1D (vertical scroll)",
                            lazyHGrid: "1D (horizontal scroll)"
                        )

                        GridComparisonRow(
                            feature: "Loading",
                            grid: "Eager (all cells)",
                            lazyVGrid: "Lazy (as needed)",
                            lazyHGrid: "Lazy (as needed)"
                        )

                        GridComparisonRow(
                            feature: "Scrolling",
                            grid: "No built-in scroll",
                            lazyVGrid: "Vertical",
                            lazyHGrid: "Horizontal"
                        )

                        GridComparisonRow(
                            feature: "Cell Spanning",
                            grid: "Yes (rows/columns)",
                            lazyVGrid: "No",
                            lazyHGrid: "No"
                        )

                        GridComparisonRow(
                            feature: "Best For",
                            grid: "Small 2D layouts",
                            lazyVGrid: "Large vertical lists",
                            lazyHGrid: "Large horizontal lists"
                        )

                        GridComparisonRow(
                            feature: "Alignment",
                            grid: "Per-column alignment",
                            lazyVGrid: "Basic alignment",
                            lazyHGrid: "Basic alignment"
                        )

                        GridComparisonRow(
                            feature: "Stability (iOS 16-17)",
                            grid: "Buggy (per book)",
                            lazyVGrid: "Stable",
                            lazyHGrid: "Stable"
                        )
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("When to Use Each")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 10) {
                            UseCaseRow(
                                icon: "square.grid.2x2",
                                title: "Grid",
                                cases: [
                                    "Small number of cells (<50)",
                                    "Need column/row spanning",
                                    "Need precise alignment control",
                                    "2D layout without scrolling"
                                ]
                            )

                            Divider()

                            UseCaseRow(
                                icon: "square.grid.3x3.fill",
                                title: "LazyVGrid",
                                cases: [
                                    "Large number of items (100+)",
                                    "Photo galleries",
                                    "Product grids",
                                    "Vertical scrolling content"
                                ]
                            )

                            Divider()

                            UseCaseRow(
                                icon: "rectangle.grid.3x2.fill",
                                title: "LazyHGrid",
                                cases: [
                                    "Large number of items (100+)",
                                    "Horizontal carousels",
                                    "Category rows",
                                    "Horizontal scrolling content"
                                ]
                            )
                        }
                    }
                })
            }
            .padding()
        }
    }
}

struct GridComparisonRow: View {
    let feature: String
    let grid: String
    let lazyVGrid: String
    let lazyHGrid: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(feature)
                .font(.caption)
                .bold()

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Grid:")
                        .font(.caption2)
                        .foregroundColor(.blue)
                        .frame(width: 80, alignment: .leading)
                    Text(grid)
                        .font(.caption2)
                }

                HStack {
                    Text("LazyVGrid:")
                        .font(.caption2)
                        .foregroundColor(.green)
                        .frame(width: 80, alignment: .leading)
                    Text(lazyVGrid)
                        .font(.caption2)
                }

                HStack {
                    Text("LazyHGrid:")
                        .font(.caption2)
                        .foregroundColor(.orange)
                        .frame(width: 80, alignment: .leading)
                    Text(lazyHGrid)
                        .font(.caption2)
                }
            }
        }
    }
}

struct UseCaseRow: View {
    let icon: String
    let title: String
    let cases: [String]

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.subheadline)
                    .bold()

                ForEach(cases, id: \.self) { useCase in
                    HStack(alignment: .top, spacing: 6) {
                        Text("•")
                        Text(useCase)
                    }
                    .font(.caption2)
                }
            }
        }
    }
}

// MARK: - Helper Views

struct MeasuredTextGrid: View {
    @State private var gridSize: CGSize = .zero
    @State private var cell1Size: CGSize = .zero
    @State private var cell2Size: CGSize = .zero
    @State private var cell3Size: CGSize = .zero
    @State private var cell4Size: CGSize = .zero

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                GridRow {
                    Text("Very Long Text Here That Will Affect Column Width")
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.blue.opacity(0.2))
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: SizePreferenceKey1.self, value: geo.size)
                            }
                        )
                    Text("B")
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.green.opacity(0.2))
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: SizePreferenceKey2.self, value: geo.size)
                            }
                        )
                }

                GridRow {
                    Text("A")
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.blue.opacity(0.2))
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: SizePreferenceKey3.self, value: geo.size)
                            }
                        )
                    Text("B")
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.green.opacity(0.2))
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: SizePreferenceKey4.self, value: geo.size)
                            }
                        )
                }
            }
            .border(Color.gray)
            .background(
                GeometryReader { geo in
                    Color.clear
                        .preference(key: GridSizePreferenceKey.self, value: geo.size)
                }
            )
            .onPreferenceChange(GridSizePreferenceKey.self) { gridSize = $0 }
            .onPreferenceChange(SizePreferenceKey1.self) { cell1Size = $0 }
            .onPreferenceChange(SizePreferenceKey2.self) { cell2Size = $0 }
            .onPreferenceChange(SizePreferenceKey3.self) { cell3Size = $0 }
            .onPreferenceChange(SizePreferenceKey4.self) { cell4Size = $0 }

            VStack(alignment: .leading, spacing: 4) {
                Text("Measured Sizes:")
                    .font(.caption)
                    .bold()
                Text("Grid: \(Int(gridSize.width))×\(Int(gridSize.height))")
                    .font(.caption2)
                Text("Row 1, Col 1: \(Int(cell1Size.width))×\(Int(cell1Size.height))")
                    .font(.caption2)
                    .foregroundColor(.blue)
                Text("Row 1, Col 2: \(Int(cell2Size.width))×\(Int(cell2Size.height))")
                    .font(.caption2)
                    .foregroundColor(.green)
                Text("Row 2, Col 1: \(Int(cell3Size.width))×\(Int(cell3Size.height))")
                    .font(.caption2)
                    .foregroundColor(.blue)
                Text("Row 2, Col 2: \(Int(cell4Size.width))×\(Int(cell4Size.height))")
                    .font(.caption2)
                    .foregroundColor(.green)

                if cell1Size.width > 0 && cell3Size.width > 0 {
                    Text("↑ Notice: Both Column 1 cells have SAME width (\(Int(cell1Size.width))pt)")
                        .font(.caption2)
                        .foregroundColor(.orange)
                        .bold()
                        .padding(.top, 4)
                }
            }
            .padding(8)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(5)
        }
    }
}

struct GridSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct SizePreferenceKey1: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct SizePreferenceKey2: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct SizePreferenceKey3: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct SizePreferenceKey4: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct LayoutStep: View {
    let step: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(step)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .background(Circle().fill(Color.blue))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .bold()
                Text(description)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TabView {
        WhyGridsExample()
            .tabItem { Label("Why Grids?", systemImage: "1.circle") }

        GridExamples()
            .tabItem { Label("Grid", systemImage: "2.circle") }

        LazyVGridExamples()
            .tabItem { Label("LazyVGrid", systemImage: "3.circle") }

        LazyHGridExamples()
            .tabItem { Label("LazyHGrid", systemImage: "4.circle") }

        LazyGridLoadingDemo()
            .tabItem { Label("Lazy Loading", systemImage: "5.circle") }

        GridComparisonView()
            .tabItem { Label("Comparison", systemImage: "6.circle") }
    }
}
