//
//  GridBasicsExample.swift
//  ThinkingInSwiftUI
//
//  Grid Basics - Understanding Grid's Row-Oriented Structure
//

import SwiftUI

struct GridBasicsExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Grid Basics")
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
                            GridRow {
                                Text("A")
                                Text("B")
                                Text("C")
                            }
                            GridRow {
                                Text("D")
                                Text("E")
                                Text("F")
                            }
                        }

                        Text("Grid sees 3 cells in each row → creates 3 columns automatically!")
                            .font(.caption)
                            .foregroundColor(.green)
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
            }
            .padding()
        }
    }
}

#Preview {
    GridBasicsExample()
}
