//
//  GridHelpers.swift
//  ThinkingInSwiftUI
//
//  Helper views for Grid examples
//

import SwiftUI

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
                    Divider()
                        .padding(.vertical, 4)

                    Text("↑ Notice: Both Column 1 cells have SAME width (\(Int(cell1Size.width))pt)")
                        .font(.caption2)
                        .foregroundColor(.orange)
                        .bold()

                    Text("What happened with YOUR device width:")
                        .font(.caption2)
                        .bold()
                        .padding(.top, 4)

                    let totalWidth = Int(gridSize.width)
                    let colWidth = Int(cell1Size.width)
                    let spacing = 10
                    let col1Height = Int(cell1Size.height)
                    let col2Height = Int(cell2Size.height)
                    let rowHeight = max(col1Height, col2Height)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("1. Grid got \(totalWidth)pt width from parent")
                            .font(.caption2)
                        Text("2. Divided equally: (\(totalWidth) - \(spacing)) / 2 = \(colWidth)pt per column")
                            .font(.caption2)
                        Text("3. Long text wrapped in \(colWidth)pt → \(col1Height)pt tall")
                            .font(.caption2)
                        Text("4. Row 1 height = max(\(col1Height), \(col2Height)) = \(rowHeight)pt")
                            .font(.caption2)
                        Text("5. Final Grid: \(totalWidth)×\(Int(gridSize.height))")
                            .font(.caption2)
                            .bold()
                    }
                    .foregroundColor(.secondary)
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

struct ModifierDescription: View {
    let number: String
    let name: String
    let description: String
    let color: Color

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text(number)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .background(Circle().fill(color))

            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.caption)
                    .bold()
                    .foregroundColor(color)
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
