//
//  GridsBasics.swift
//  ThinkingInSwiftUI
//
//  Grid (iOS 16+) - Basics and Examples
//  TODO: This file is 1031 lines and needs further splitting
//

import SwiftUI

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

                        Text("📏 Default Column Sizing")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.blue)
                            .padding(.top, 8)

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

                        Divider()
                            .padding(.vertical, 8)

                        Text("🎨 Customizing Column Widths")
                            .font(.subheadline)
                            .bold()
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
                                    .frame(maxWidth: .infinity)  // Flexible
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                Text("B")
                                    .fixedSize()  // Content-sized
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }

                            GridRow {
                                Text("Also flexible")
                                    .frame(maxWidth: .infinity)  // Flexible
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                Text("B")
                                    .fixedSize()  // Content-sized
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }
                        }
                        .border(Color.gray)

                        Text("↑ Column 1 expands, Column 2 width = max('B', 'B') = natural 'B' width")
                            .font(.caption2)
                            .foregroundColor(.purple)

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

                        Divider()
                            .padding(.vertical, 8)

                        Text("Detailed Algorithm for Text Example")
                            .font(.subheadline)
                            .bold()

                        Text("⚠️ Note: The numbers below are examples to illustrate the algorithm. The actual measured sizes above will differ based on your device's screen width.")
                            .font(.caption2)
                            .foregroundColor(.orange)
                            .padding(8)
                            .background(Color.orange.opacity(0.1))
                            .cornerRadius(5)

                        VStack(alignment: .leading, spacing: 12) {
                            Text("PASS 1: LAYOUT PASS (Example with 350pt screen width)")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.blue)

                            LayoutStep(
                                step: "1",
                                title: "Grid receives proposal",
                                description: "Parent proposes full width (e.g., 350×∞)"
                            )

                            LayoutStep(
                                step: "2",
                                title: "Grid proposes same to all cells",
                                description: """
                                Row 1, Col 1: Proposes 350×∞
                                Row 1, Col 2: Proposes 350×∞
                                Row 2, Col 1: Proposes 350×∞
                                Row 2, Col 2: Proposes 350×∞
                                """
                            )

                            LayoutStep(
                                step: "3",
                                title: "Grid divides width among columns",
                                description: """
                                Grid has 350pt to work with
                                Grid uses FLEXIBLE EQUAL-WIDTH columns by default
                                With 2 columns + spacing: (350 - 10) / 2 = 170pt per column
                                Grid proposes 170pt width to each cell
                                (This is Grid's default behavior without explicit GridItem sizing)
                                """
                            )

                            LayoutStep(
                                step: "4",
                                title: "Cells report sizes with proposed width",
                                description: """
                                Row 1, Col 1: "Very Long..." with 170pt width
                                  → Text WRAPS to 4 lines! Reports 170×80
                                Row 1, Col 2: "B" with 170pt → Reports 170×20
                                Row 2, Col 1: "A" with 170pt → Reports 170×20
                                Row 2, Col 2: "B" with 170pt → Reports 170×20
                                (Due to .frame(maxWidth: .infinity), text accepts width and wraps!)
                                """
                            )

                            LayoutStep(
                                step: "5",
                                title: "Grid calculates final column widths",
                                description: """
                                Column 1: max(170, 170) = 170 (all cells accepted 170pt)
                                Column 2: max(170, 170) = 170
                                Total width: 170 + 10 + 170 = 350
                                """
                            )

                            LayoutStep(
                                step: "6",
                                title: "Grid calculates row heights",
                                description: """
                                Row 1: max(80, 20) = 80 (text wrapped to 4 lines!)
                                Row 2: max(20, 20) = 20
                                Total height: 80 + 10 + 20 = 110
                                """
                            )

                            LayoutStep(
                                step: "7",
                                title: "Grid reports its size",
                                description: "Grid reports: 350×110 to parent"
                            )

                            Text("PASS 2: RENDER PASS")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.green)
                                .padding(.top, 8)

                            LayoutStep(
                                step: "8",
                                title: "Grid starts with calculated size",
                                description: "Grid now has 350×110 from Pass 1"
                            )

                            LayoutStep(
                                step: "9",
                                title: "Grid re-proposes with final column/row sizes",
                                description: """
                                Row 1, Col 1: Proposes 170×80 (column 1 width × row 1 height)
                                Row 1, Col 2: Proposes 170×80 (column 2 width × row 1 height)
                                Row 2, Col 1: Proposes 170×20 (column 1 width × row 2 height)
                                Row 2, Col 2: Proposes 170×20 (column 2 width × row 2 height)
                                """
                            )

                            LayoutStep(
                                step: "10",
                                title: "Grid positions cells",
                                description: """
                                Row 1, Col 1: Position (0, 0), wrapped text fills 170×80
                                Row 1, Col 2: Position (180, 0), "B" in 170×80 space
                                Row 2, Col 1: Position (0, 90), "A" in 170×20 space
                                Row 2, Col 2: Position (180, 90), "B" in 170×20 space
                                """
                            )

                            LayoutStep(
                                step: "✓",
                                title: "Final layout complete!",
                                description: """
                                All Column 1 cells have width=170pt (coordinated!)
                                Row 1 is taller (80pt) because long text wrapped
                                Row 2 is shorter (20pt) but still gets same column widths
                                """
                            )
                        }

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

                // MARK: - Custom Column Widths

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Custom Column Widths")
                            .font(.headline)

                        Text("Mix flexible, fixed, and adaptive columns:")
                            .font(.subheadline)

                        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                            GridRow {
                                Text("Label:")
                                    .fixedSize()  // Column 1: Adaptive (natural size)
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))

                                Text("This is flexible content that expands")
                                    .frame(maxWidth: .infinity)  // Column 2: Flexible
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))

                                Image(systemName: "star.fill")
                                    .fixedSize()  // Column 3: Adaptive (icon size)
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }

                            GridRow {
                                Text("Name:")
                                    .fixedSize()  // Column 1: Adaptive
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))

                                Text("Short text")
                                    .frame(maxWidth: .infinity)  // Column 2: Flexible
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))

                                Image(systemName: "checkmark")
                                    .fixedSize()  // Column 3: Adaptive
                                    .padding(8)
                                    .background(Color.green.opacity(0.2))
                            }

                            GridRow {
                                Text("Description:")
                                    .fixedSize()  // Column 1: Adaptive
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))

                                Text("Another flexible column that takes remaining space")
                                    .frame(maxWidth: .infinity)  // Column 2: Flexible
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))

                                Image(systemName: "heart.fill")
                                    .fixedSize()  // Column 3: Adaptive
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
                            Text("  → Each cell reports ideal width: 'Label:' ~50pt, 'Description:' ~85pt")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("  → Grid takes MAX → Column width = 85pt for ALL cells")
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

                // MARK: - Grid Modifiers

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

                        Text("Let's see each one in action:")
                            .font(.caption)
                            .padding(.top, 8)
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

                        Text("Code example:")
                            .font(.caption)
                            .padding(.top, 4)

                        Text("""
                        GridRow {  // First row
                            Text("Col 1")
                                .gridColumnAlignment(.leading)
                            Text("Col 2")
                                .gridColumnAlignment(.center)
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
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
                            Text("  → Column 1 width determined by 'Unsized horizontal'")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text("  → Column 2 width determined by 'Short'")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }

                        Text("💡 .gridCellUnsizedAxes(.horizontal) is similar to .fixedSize()")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 4)

                        Text("Code example:")
                            .font(.caption)
                            .padding(.top, 4)

                        Text("""
                        Text("Label:")
                            .gridCellUnsizedAxes(.horizontal)
                        // Column width = natural size of "Label:"
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
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

                        Text("Code example:")
                            .font(.caption)
                            .padding(.top, 4)

                        Text("""
                        Text("Content")
                            .gridCellAnchor(.center)
                        // Positions content at center of cell
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                })

            }
            .padding()
        }
    }
}


// MARK: - Preview

#Preview {
    GridExamples()
}
