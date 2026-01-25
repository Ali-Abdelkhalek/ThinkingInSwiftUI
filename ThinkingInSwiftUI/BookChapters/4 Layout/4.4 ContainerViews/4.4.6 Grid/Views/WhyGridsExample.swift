//
//  GridsIntroduction.swift
//  ThinkingInSwiftUI
//
//  Understanding Grid, LazyVGrid, and LazyHGrid - Introduction
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

                        Divider()
                            .padding(.vertical, 8)

                        Text("🤔 Why Is Grid Syntax So Different?")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Grid vs LazyVGrid have completely different syntax because they solve different problems:")
                                .font(.caption)

                            VStack(alignment: .leading, spacing: 6) {
                                HStack(alignment: .top, spacing: 8) {
                                    Text("•")
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Grid = 2D Table/Form Layout")
                                            .font(.caption)
                                            .bold()
                                        Text("Explicit structure: You define ROWS with GridRow")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                        Text("Like HTML <table> with <tr> rows")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                        Text("Full control: cell spanning, per-column alignment, 2D coordination")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }

                                HStack(alignment: .top, spacing: 8) {
                                    Text("•")
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("LazyVGrid = 1D Flowing Grid")
                                            .font(.caption)
                                            .bold()
                                        Text("Auto-flow: Define column structure, items flow into it")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                        Text("Like CSS Grid with grid-template-columns + auto-flow")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                        Text("You specify: columns = [GridItem(...), GridItem(...)]")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                        Text("Then: Items automatically fill columns top-to-bottom")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }

                            Text("Syntax comparison:")
                                .font(.caption)
                                .bold()
                                .padding(.top, 8)

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Grid (Explicit Rows):")
                                    .font(.caption2)
                                    .foregroundColor(.blue)

                                Text("""
                                Grid {
                                    GridRow { Text("A"); Text("B") }
                                    GridRow { Text("C"); Text("D") }
                                }
                                // You control: which row each item goes in
                                """)
                                .font(.system(.caption2, design: .monospaced))
                                .padding(8)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(5)

                                Text("LazyVGrid (Auto-Flow):")
                                    .font(.caption2)
                                    .foregroundColor(.green)

                                Text("""
                                let cols = [GridItem(.flexible()), GridItem(.flexible())]
                                LazyVGrid(columns: cols) {
                                    Text("A"); Text("B")
                                    Text("C"); Text("D")
                                }
                                // Items auto-flow: A→col1, B→col2, C→col1, D→col2
                                """)
                                .font(.system(.caption2, design: .monospaced))
                                .padding(8)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(5)
                            }

                            Text("Why the difference?")
                                .font(.caption)
                                .bold()
                                .padding(.top, 8)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("• Grid needs GridRow because you might want cell spanning, different column counts per row, precise 2D control")
                                    .font(.caption2)
                                Text("• LazyVGrid uses GridItem[] because columns are FIXED - you're defining a repeating pattern for thousands of items")
                                    .font(.caption2)
                                Text("• Grid = \"I know my table structure\" (forms, settings, small layouts)")
                                    .font(.caption2)
                                    .foregroundColor(.blue)
                                Text("• LazyVGrid = \"I have 1000 items, flow them into 3 columns\" (photos, products)")
                                    .font(.caption2)
                                    .foregroundColor(.green)
                            }
                        }
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

// MARK: - Preview

#Preview {
    WhyGridsExample()
}
