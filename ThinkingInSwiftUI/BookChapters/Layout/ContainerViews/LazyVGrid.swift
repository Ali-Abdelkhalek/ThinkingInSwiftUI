//
//  LazyVGrid.swift
//  ThinkingInSwiftUI
//
//  LazyVGrid Examples
//

import SwiftUI

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

                // MARK: - Anomalous Items Issue

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("⚠️ Problem: Anomalous Items")
                            .font(.headline)

                        Text("What happens when ONE item has different size?")
                            .font(.subheadline)

                        Text("Flexible columns with anomalous item:")
                            .font(.caption)
                            .padding(.top, 8)

                        let flexibleColumns = [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ]

                        LazyVGrid(columns: flexibleColumns, spacing: 10) {
                            ForEach(0..<9) { i in
                                if i == 4 {
                                    // Anomalous item in column 2
                                    Text("Very Long Anomalous Item That Breaks The Grid Layout")
                                        .frame(maxWidth: .infinity)
                                        .padding(8)
                                        .background(Color.red.opacity(0.3))
                                } else {
                                    Text("\(i)")
                                        .frame(maxWidth: .infinity)
                                        .padding(8)
                                        .background(Color.blue.opacity(0.3))
                                }
                            }
                        }

                        Text("↑ Notice: Item 4 forces column 2 to be MUCH wider, affecting items 1, 4, 7")
                            .font(.caption2)
                            .foregroundColor(.red)

                        Divider()

                        Text("Adaptive columns with varying sizes:")
                            .font(.caption)
                            .padding(.top, 8)

                        let adaptiveColumns = [
                            GridItem(.adaptive(minimum: 60))
                        ]

                        LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                            ForEach(0..<12) { i in
                                if i == 3 {
                                    Text("Anomalous Wide")
                                        .padding(8)
                                        .background(Color.red.opacity(0.3))
                                } else {
                                    Text("\(i)")
                                        .padding(8)
                                        .background(Color.green.opacity(0.3))
                                }
                            }
                        }

                        Text("↑ Adaptive struggles with inconsistent item sizes")
                            .font(.caption2)
                            .foregroundColor(.red)

                        Divider()

                        Text("✅ Solutions:")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("1. Use .fixed() to enforce strict column widths")
                                .font(.caption2)
                            Text("2. Clamp sizes with .frame(maxWidth:, maxHeight:)")
                                .font(.caption2)
                            Text("3. Use .aspectRatio() for consistent shapes")
                                .font(.caption2)
                            Text("4. Truncate text with .lineLimit()")
                                .font(.caption2)
                        }

                        Text("Fixed columns solution:")
                            .font(.caption)
                            .padding(.top, 8)

                        let fixedColumnsSolution = [
                            GridItem(.fixed(80)),
                            GridItem(.fixed(80)),
                            GridItem(.fixed(80))
                        ]

                        LazyVGrid(columns: fixedColumnsSolution, spacing: 10) {
                            ForEach(0..<9) { i in
                                if i == 4 {
                                    Text("Very Long Anomalous Item")
                                        .lineLimit(2)
                                        .frame(width: 80, height: 60)
                                        .padding(4)
                                        .background(Color.green.opacity(0.3))
                                } else {
                                    Text("\(i)")
                                        .frame(width: 80, height: 60)
                                        .padding(4)
                                        .background(Color.blue.opacity(0.3))
                                }
                            }
                        }

                        Text("↑ Fixed widths + lineLimit() = consistent grid")
                            .font(.caption2)
                            .foregroundColor(.green)

                        Text("Clamped flexible solution:")
                            .font(.caption)
                            .padding(.top, 8)

                        LazyVGrid(columns: flexibleColumns, spacing: 10) {
                            ForEach(0..<9) { i in
                                if i == 4 {
                                    Text("Very Long Item")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .padding(4)
                                        .background(Color.green.opacity(0.3))
                                } else {
                                    Text("\(i)")
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .padding(4)
                                        .background(Color.blue.opacity(0.3))
                                }
                            }
                        }

                        Text("↑ Flexible + .lineLimit(1) + fixed height = better balance")
                            .font(.caption2)
                            .foregroundColor(.green)

                        Text("💡 Key insight: Real-world data isn't uniform - always constrain item sizes!")
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


// MARK: - Preview

#Preview {
    LazyVGridExamples()
}
