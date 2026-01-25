//
//  LazyHGridAndComparison.swift
//  ThinkingInSwiftUI
//
//  LazyHGrid, Lazy Loading, and Grid Comparison
//

import SwiftUI

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


// MARK: - Preview

#Preview {
    TabView {
        LazyHGridExamples().tabItem { Label("LazyHGrid", systemImage: "1.circle") }
        LazyGridLoadingDemo().tabItem { Label("Lazy Loading", systemImage: "2.circle") }
        GridComparisonView().tabItem { Label("Comparison", systemImage: "3.circle") }
    }
}
