//
//  GeometryReaderAdvanced.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Container Views - GeometryReader Advanced
//  Correct usage patterns and advanced techniques
//

import SwiftUI

// MARK: - Solution 2: GeometryReader in Background/Overlay
//
// When we put a GeometryReader inside a background or overlay modifier, it won't
// influence the size of the primary view. The size of the primary view will be
// proposed to the GeometryReader, allowing us to measure it.

struct BackgroundOverlaySolution: View {
    @State private var textSize: CGSize = .zero

    var body: some View {
        VStack(spacing: 30) {
            Text("Measured Text")
                .font(.title)
                .padding()
                .background(Color.green.opacity(0.3))
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                textSize = proxy.size
                            }
                    }
                )

            Text("Width: \(Int(textSize.width))")
            Text("Height: \(Int(textSize.height))")
        }
        .padding()
    }
}

// MARK: - Practical Example: Reading Multiple Geometry Values

struct ComprehensiveGeometryExample: View {
    @State private var size: CGSize = .zero
    @State private var safeAreaInsets: EdgeInsets = EdgeInsets()
    @State private var globalFrame: CGRect = .zero

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Group {
                        Text("GeometryProxy Information")
                            .font(.title)
                            .bold()

                        Divider()

                        Text("Size:")
                            .font(.headline)
                        Text("Width: \(Int(proxy.size.width))")
                        Text("Height: \(Int(proxy.size.height))")

                        Divider()

                        Text("Safe Area Insets:")
                            .font(.headline)
                        Text("Top: \(Int(proxy.safeAreaInsets.top))")
                        Text("Bottom: \(Int(proxy.safeAreaInsets.bottom))")
                        Text("Leading: \(Int(proxy.safeAreaInsets.leading))")
                        Text("Trailing: \(Int(proxy.safeAreaInsets.trailing))")
                    }

                    Divider()

                    Text("Global Frame:")
                        .font(.headline)
                    Text("Origin: (\(Int(proxy.frame(in: .global).origin.x)), \(Int(proxy.frame(in: .global).origin.y)))")
                    Text("Size: \(Int(proxy.frame(in: .global).width)) × \(Int(proxy.frame(in: .global).height))")
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .border(Color.red, width: 2)
    }
}

// MARK: - Example: Centering Content in GeometryReader
//
// Since GeometryReader uses top-leading alignment, if we want to center content,
// we need to do it explicitly.
//
// KEY INSIGHT: .frame(alignment:) doesn't work alone because it only controls
// how the view is positioned within its OWN size. To center in GeometryReader,
// you must FILL the space first using width and height from proxy.size.

struct CenteringInGeometryReader: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Centering in GeometryReader")
                .font(.headline)

            // 1. Default top-leading placement
            GeometryReader { _ in
                Text("Top-Leading (Default)")
                    .padding()
                    .background(Color.blue.opacity(0.3))
            }
            .frame(height: 100)
            .border(Color.red, width: 2)
            Text("↑ No frame modifier")
                .font(.caption2)

            // 2. WRONG: Using only .frame(alignment:) doesn't work
            GeometryReader { _ in
                Text("Still Top-Leading!")
                    .padding()
                    .background(Color.orange.opacity(0.3))
                    .frame(alignment: .center)
            }
            .frame(height: 100)
            .border(Color.red, width: 2)
            Text("↑ .frame(alignment: .center) doesn't fill space")
                .font(.caption2)

            // 3. CORRECT: Fill the space with width/height, then center
            GeometryReader { proxy in
                Text("Actually Centered!")
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .frame(height: 100)
            .border(Color.red, width: 2)
            Text("↑ .frame(width:height:) fills GeometryReader space")
                .font(.caption2)
        }
        .padding()
    }
}

// MARK: - Example: Measuring Dynamic Content

struct MeasuringDynamicContent: View {
    @State private var text = "Short"
    @State private var measuredSize: CGSize = .zero

    var body: some View {
        VStack(spacing: 20) {
            Text(text)
                .font(.title)
                .padding()
                .background(Color.blue.opacity(0.2))
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
                )
                .onPreferenceChange(SizePreferenceKey.self) { newSize in
                    measuredSize = newSize
                }

            Text("Measured Size: \(Int(measuredSize.width)) × \(Int(measuredSize.height))")
                .font(.caption)

            HStack {
                Button("Short") { text = "Short" }
                Button("Medium Length") { text = "Medium Length" }
                Button("Very Long Text Here") { text = "Very Long Text Here" }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

// MARK: - Supporting Types

fileprivate struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

// MARK: - Preview

#Preview {
    TabView {
        BackgroundOverlaySolution()
            .tabItem { Label("Background", systemImage: "1.circle") }

        ComprehensiveGeometryExample()
            .tabItem { Label("Comprehensive", systemImage: "2.circle") }

        CenteringInGeometryReader()
            .tabItem { Label("Centering", systemImage: "3.circle") }

        MeasuringDynamicContent()
            .tabItem { Label("Dynamic", systemImage: "4.circle") }
    }
}
