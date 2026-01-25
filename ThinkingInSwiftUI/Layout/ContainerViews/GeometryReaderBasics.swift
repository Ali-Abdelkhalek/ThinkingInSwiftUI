//
//  GeometryReaderBasics.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Container Views - GeometryReader Basics
//  Understanding how GeometryReader works and common pitfalls
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
    }
}
