//
//  GeometryReader.swift
//  ThinkingInSwiftUI
//
//  Created by Ali Abdelkhalek on 07/04/2025.
//

import SwiftUI

// MARK: - GeometryReader Basics
//
// GeometryReader is a container that always accepts the proposed size and reports
// that size to its view builder closure via a GeometryProxy.
//
// The GeometryProxy provides access to:
// - size: The size of the geometry reader
// - safeAreaInsets: Current safe area insets
// - frame(in:): Frame of the view in a specific coordinate space
// - Anchor resolution capabilities
//
// IMPORTANT: GeometryReader has TWO unique behaviors:
// 1. SIZE: Always accepts the full proposed size (unlike views that size to content)
// 2. POSITION: Places content at top-leading (0, 0) instead of centering like other containers
//
// This makes GeometryReader special - it's the only container that doesn't center its content.

// MARK: - Basic Example: Showing Proposed Size

struct BasicGeometryReaderExample: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading, spacing: 8) {
                Text("Size: \(Int(proxy.size.width)) × \(Int(proxy.size.height))")
                    .font(.headline)

                Text("Notice: Text is at top-leading (0, 0)")
                    .font(.caption)

                Text("GeometryReader accepts ALL proposed space")
                    .font(.caption)
            }
            .padding()
            .background(Color.blue.opacity(0.2))
        }
        .border(Color.red, width: 2)
    }
}

// MARK: - The Problem: GeometryReader Influences Layout
//
// Because GeometryReader always accepts the proposed size, wrapping a view with it
// will affect the layout. For example, if we try to measure the width of a Text view
// by wrapping it in a GeometryReader, the text will no longer determine its own size.

struct ProblemExample: View {
    var body: some View {
        VStack(spacing: 20) {
            // Text without GeometryReader - takes its natural size
            Text("Hello, SwiftUI!")
                .padding()
                .background(Color.green)
                .border(Color.blue, width: 2)

            // Text with GeometryReader - GeometryReader takes all available space
            GeometryReader { proxy in
                Text("Hello, SwiftUI!")
                    .padding()
                    .background(Color.green)
                    .border(Color.blue, width: 2)
            }
            .border(Color.red, width: 2)
        }
        .padding()
    }
}

// MARK: - Top-Leading vs Center Alignment
//
// GeometryReader places its subviews at top-leading (0, 0) by default, unlike other
// container views which use center alignment.
//
// This means GeometryReader affects BOTH:
// 1. SIZE: Always accepts the proposed size
// 2. POSITION: Places content at top-leading corner

struct GeometryReaderAlignmentExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Compare Positioning Behavior")
                .font(.headline)

            // VStack uses center alignment by default
            VStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 50, height: 50)
                Text("Centered")
                    .font(.caption)
            }
            .frame(height: 150)
            .border(Color.blue, width: 2)
            Text("↑ VStack centers content")
                .font(.caption2)

            // GeometryReader uses top-leading alignment by default
            GeometryReader { _ in
                VStack {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 50, height: 50)
                    Text("At (0, 0)")
                        .font(.caption)
                }
            }
            .frame(height: 150)
            .border(Color.red, width: 2)
            Text("↑ GeometryReader places at top-leading")
                .font(.caption2)
        }
        .padding()
    }
}

// MARK: - Solution 1: Wrapping Flexible Views
//
// When we wrap a completely flexible view (like ScrollView) inside a GeometryReader,
// it won't affect the layout because the flexible view accepts the proposed size anyway.

struct FlexibleViewSolution: View {
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    Text("ScrollView Size: \(Int(proxy.size.width)) × \(Int(proxy.size.height))")
                        .font(.headline)
                        .padding()
                        .background(Color.blue.opacity(0.2))

                    ForEach(0..<20) { i in
                        Text("Item \(i)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                    }
                }
                .padding()
            }
        }
        .border(Color.red, width: 2)
    }
}

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

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

// MARK: - Preview

#Preview {
    TabView {
        BasicGeometryReaderExample()
            .tabItem { Label("Basic", systemImage: "1.circle") }

        ProblemExample()
            .tabItem { Label("Problem", systemImage: "2.circle") }

        GeometryReaderAlignmentExample()
            .tabItem { Label("Alignment", systemImage: "3.circle") }

        FlexibleViewSolution()
            .tabItem { Label("Flexible Views", systemImage: "4.circle") }

        BackgroundOverlaySolution()
            .tabItem { Label("Background", systemImage: "5.circle") }

        ComprehensiveGeometryExample()
            .tabItem { Label("Comprehensive", systemImage: "6.circle") }

        CenteringInGeometryReader()
            .tabItem { Label("Centering", systemImage: "7.circle") }

        MeasuringDynamicContent()
            .tabItem { Label("Dynamic", systemImage: "8.circle") }
    }
}
