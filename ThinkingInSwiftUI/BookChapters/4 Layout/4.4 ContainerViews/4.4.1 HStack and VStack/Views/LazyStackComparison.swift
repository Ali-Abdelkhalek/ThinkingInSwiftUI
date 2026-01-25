//
//  LazyStackComparison.swift
//  ThinkingInSwiftUI
//
//  HStack and VStack - Lazy Stack Comparison
//

import SwiftUI


struct LazyStackComparison: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("🔄 LazyHStack vs HStack")
                    .font(.title)
                    .bold()

                // MARK: - Space Distribution Difference

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Space Distribution Difference")
                            .font(.headline)

                        Text("HStack distributes space:")
                            .font(.subheadline)

                        HStack(spacing: 0) {
                            Color.cyan
                            Text("Hello")
                            Color.teal
                        }
                        .frame(width: 300, height: 60)
                        .border(Color.red, width: 2)

                        Text("↑ Colors expand to fill 300pt")
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        Divider()

                        Text("LazyHStack proposes nil (ideal widths):")
                            .font(.subheadline)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 0) {
                                Color.cyan
                                    .frame(width: 80)
                                Text("Hello")
                                Color.teal
                                    .frame(width: 80)
                            }
                        }
                        .frame(width: 300, height: 60)
                        .border(Color.red, width: 2)

                        Text("↑ Each view uses its ideal/specified width")
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        Text("Key Insight: LazyHStack proposes nil×height, so views don't get distributed space!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 5)
                    }
                }

                // MARK: - Lazy Loading Demo

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Lazy Loading")
                            .font(.headline)

                        Text("Regular VStack (eager):")
                            .font(.subheadline)

                        ScrollView {
                            VStack {
                                ForEach(0..<50, id: \.self) { i in
                                    Text("Item \(i)")
                                        .padding(.vertical, 4)
                                        .onAppear {
                                            // All fire immediately!
                                            print("Regular VStack - Item \(i) appeared")
                                        }
                                }
                            }
                        }
                        .frame(height: 150)
                        .border(Color.gray)

                        Text("↑ All 50 onAppear calls fire immediately")
                            .font(.caption2)
                            .foregroundColor(.orange)

                        Divider()

                        Text("LazyVStack (lazy):")
                            .font(.subheadline)

                        LazyLoadingCounter()

                        Text("↑ Only visible items fire onAppear")
                            .font(.caption2)
                            .foregroundColor(.green)
                    }
                }

                // MARK: - Height Estimation

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Height Estimation")
                            .font(.headline)

                        Text("LazyVStack estimates total height from visible views (like List):")
                            .font(.subheadline)

                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(0..<100, id: \.self) { i in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Item \(i)")
                                            .font(.headline)

                                        if i % 5 == 0 {
                                            Text("Taller item with extra content")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(8)
                                    .background(i % 2 == 0 ? Color.blue.opacity(0.1) : Color.clear)
                                }
                            }
                            .padding()
                        }
                        .frame(height: 200)
                        .border(Color.gray)

                        Text("Notice: Scroll indicator size changes as you scroll (height estimation updates)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }

                // MARK: - Summary

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Summary: Regular vs Lazy Stacks")
                            .font(.headline)

                        LazyStackComparisonTable()
                    }
                }
            }
            .padding()
        }
    }
}

struct LazyLoadingCounter: View {
    @State private var appearedCount = 0

    var body: some View {
        VStack(spacing: 8) {
            Text("Appeared: \(appearedCount) / 50 items")
                .font(.caption)
                .foregroundColor(.secondary)

            ScrollView {
                LazyVStack {
                    ForEach(0..<50, id: \.self) { i in
                        Text("Item \(i)")
                            .padding(.vertical, 4)
                            .onAppear {
                                appearedCount += 1
                                print("LazyVStack - Item \(i) appeared")
                            }
                            .onDisappear {
                                appearedCount -= 1
                            }
                    }
                }
            }
            .frame(height: 150)
            .border(Color.gray)
        }
    }
}

struct LazyStackComparisonTable: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ComparisonTableRow(
                aspect: "Size",
                regular: "Union of subviews' frames",
                lazy: "Union of subviews' frames ✓"
            )

            ComparisonTableRow(
                aspect: "Space Distribution",
                regular: "Divides based on flexibility",
                lazy: "Proposes nil (ideal sizes) ⚠️"
            )

            ComparisonTableRow(
                aspect: "View Creation",
                regular: "All views created immediately",
                lazy: "Created lazily in ScrollView ✓"
            )

            ComparisonTableRow(
                aspect: "Size Estimation",
                regular: "Knows exact size upfront",
                lazy: "Estimates from visible views ⚠️"
            )

            ComparisonTableRow(
                aspect: "Best For",
                regular: "Small lists, need distribution",
                lazy: "Large lists (100+), ScrollView"
            )
        }
        .padding(8)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(6)
    }
}

struct ComparisonTableRow: View {
    let aspect: String
    let regular: String
    let lazy: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(aspect)
                .font(.caption)
                .bold()

            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Regular:")
                        .font(.caption2)
                        .foregroundColor(.blue)
                    Text(regular)
                        .font(.caption2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Lazy:")
                        .font(.caption2)
                        .foregroundColor(.green)
                    Text(lazy)
                        .font(.caption2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

