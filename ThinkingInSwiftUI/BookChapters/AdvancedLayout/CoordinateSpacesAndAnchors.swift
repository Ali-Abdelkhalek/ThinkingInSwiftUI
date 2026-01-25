//
//  CoordinateSpacesAndAnchors.swift
//  ThinkingInSwiftUI
//
//  Chapter 7: Advanced Layout - Coordinate Spaces & Anchors
//  Understanding positioning and anchor-based layout
//

import SwiftUI

// MARK: - Tab 1: Coordinate Spaces

struct CoordinateSpacesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Coordinate Spaces")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What Are Coordinate Spaces?")
                            .font(.headline)

                        Text("""
                        A coordinate space defines the origin (0,0) and scale for measurements.

                        GeometryReader can measure a view's frame in DIFFERENT coordinate spaces:

                        Built-in spaces:
                        • .global - Screen's top-leading corner
                        • .local - Current view's top-leading corner

                        Custom spaces:
                        • .named("MySpace") - Define your own reference point
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Example") {
                    VStack(spacing: 15) {
                        VStack(spacing: 20) {
                            Text("Hello")
                                .padding()
                                .background(Color.blue.opacity(0.2))

                            Text("World")
                                .padding()
                                .background(Color.green.opacity(0.2))
                                .overlay {
                                    GeometryReader { proxy in
                                        Color.clear
                                            .onAppear {
                                                print("Global:", proxy.frame(in: .global).origin)
                                                print("Local:", proxy.frame(in: .local).origin)
                                                print("Named:", proxy.frame(in: .named("Stack")).origin)
                                            }
                                    }
                                }
                        }
                        .coordinateSpace(name: "Stack")
                        .border(Color.purple, width: 2)

                        Text("""
                        VStack {
                            Text("Hello")
                            Text("World")
                                .overlay {
                                    GeometryReader { proxy in
                                        proxy.frame(in: .global)  // (x, y) from screen top-left
                                        proxy.frame(in: .local)   // (0, 0) always
                                        proxy.frame(in: .named("Stack"))  // (0, y) from VStack top
                                    }
                                }
                        }
                        .coordinateSpace(name: "Stack")

                        .local always means the GeometryReader itself (always 0,0)
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Understanding the Values")
                            .font(.headline)

                        Text("""
                        Example output (iPhone):

                        Global: (167.0, 438.0)
                        • Distance from screen's top-left corner
                        • Changes with scroll position
                        • Affected by navigation bars, etc.

                        Local: (0.0, 0.0)
                        • Always (0,0) for the GeometryReader
                        • Local = the view itself

                        Named("Stack"): (0.0, 58.0)
                        • (0, 58) from VStack's top-left
                        • Second item, so y offset includes first item + spacing
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Effects and Coordinate Spaces")
                            .font(.headline)

                        Text("""
                        Effects (scaleEffect, rotationEffect, etc.) DON'T change layout.
                        But they DO change how views appear in coordinate spaces!

                        Text("Hello")
                            .overlay {
                                GeometryReader { proxy in
                                    proxy.frame(in: .global).size  // (40, 20)
                                    proxy.frame(in: .local).size   // (80, 40)
                                }
                            }
                            .scaleEffect(0.5)

                        Global: Takes scale into account → half size
                        Local: Original layout size → full size

                        Effects inside a coordinate space are considered when measuring!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 2: Custom Coordinate Spaces

struct CustomCoordinateSpacesView: View {
    @State private var positions: [String: CGPoint] = [:]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Custom Coordinate Spaces")
                    .font(.title)
                    .bold()

                GroupBox("Live Demo") {
                    VStack(spacing: 15) {
                        ScrollView {
                            VStack(spacing: 10) {
                                ForEach(0..<5, id: \.self) { idx in
                                    HStack {
                                        Text("Item \(idx)")
                                            .padding()
                                            .background(Color.blue.opacity(0.3))
                                            .overlay {
                                                GeometryReader { proxy in
                                                    Color.clear
                                                        .onAppear {
                                                            positions["item\(idx)"] = proxy.frame(in: .named("Container")).origin
                                                        }
                                                }
                                            }

                                        Spacer()

                                        if let pos = positions["item\(idx)"] {
                                            Text("y: \(Int(pos.y))")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                        .frame(height: 200)
                        .border(Color.purple, width: 2)
                        .coordinateSpace(name: "Container")

                        Text("""
                        Each item measures its position relative to "Container" space.
                        Scroll position changes don't affect these measurements!
                        """)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("When to Use Custom Spaces")
                            .font(.headline)

                        Text("""
                        Use custom coordinate spaces when you need:

                        1. Stable reference point
                           • ScrollView content relative to scroll container
                           • Views relative to specific ancestor

                        2. Multiple related measurements
                           • All children relative to same parent
                           • Avoid converting between global/local repeatedly

                        3. Avoiding global space
                           • Global changes with device orientation
                           • Global affected by navigation/tabs
                           • Custom space = more stable

                        .coordinateSpace(name: "MySpace")
                        • Place on stable ancestor
                        • Children can measure relative to it
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: Parallax Scrolling")
                            .font(.headline)

                        Text("""
                        ScrollView {
                            ForEach(items) { item in
                                ItemView(item)
                                    .overlay {
                                        GeometryReader { proxy in
                                            let offset = proxy.frame(in: .named("Scroll")).minY
                                            // Use offset for parallax effect
                                        }
                                    }
                            }
                        }
                        .coordinateSpace(name: "Scroll")

                        As items scroll:
                        • Global frame changes (affected by scroll)
                        • Named("Scroll") frame is stable relative to ScrollView
                        • Can calculate scroll progress!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 3: Anchors

struct AnchorsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Anchors")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What Are Anchors?")
                            .font(.headline)

                        Text("""
                        Anchors are built on top of:
                        • GeometryReaders
                        • Preferences
                        • Coordinate spaces

                        An Anchor<T> wraps a geometry value (CGRect, CGSize, CGPoint) measured in the GLOBAL coordinate space.

                        Purpose:
                        • Communicate position/size up the tree via preferences
                        • Automatically transform to different coordinate spaces
                        • Convenience wrapper to avoid manual coordinate conversion

                        Think: "Bookmark" to a view's geometry
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Problem Anchors Solve")
                            .font(.headline)

                        Text("""
                        Without anchors:

                        1. Measure view in GLOBAL space
                        2. Store CGRect in preference
                        3. Read preference at ancestor
                        4. Manually convert to ancestor's coordinate space
                        5. Error-prone coordinate math!

                        With anchors:

                        1. Create Anchor<CGRect> (measures in global)
                        2. Store anchor in preference
                        3. Read anchor at ancestor
                        4. GeometryProxy automatically transforms to local space!
                        5. No manual conversion needed!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Creating an Anchor")
                            .font(.headline)

                        Text("""
                        Define a PreferenceKey for the anchor:

                        struct HighlightKey: PreferenceKey {
                            typealias Value = Anchor<CGRect>?
                            static var defaultValue: Value { nil }

                            static func reduce(
                                value: inout Value,
                                nextValue: () -> Value
                            ) {
                                value = value ?? nextValue()
                            }
                        }

                        Set the anchor preference:

                        Button("Login")
                            .anchorPreference(
                                key: HighlightKey.self,
                                value: .bounds,  // Built-in anchor source
                                transform: { $0 }  // Identity - just pass through
                            )

                        .bounds is a built-in Anchor<CGRect> for the view's bounds.
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Resolving an Anchor")
                            .font(.headline)

                        Text("""
                        Read the anchor and transform to local space:

                        .overlayPreferenceValue(HighlightKey.self) { anchor in
                            if let anchor = anchor {
                                GeometryReader { proxy in
                                    let rect = proxy[anchor]  // Auto-transform!

                                    Ellipse()
                                        .strokeBorder(.red, lineWidth: 2)
                                        .frame(width: rect.width, height: rect.height)
                                        .offset(x: rect.origin.x, y: rect.origin.y)
                                }
                            }
                        }

                        proxy[anchor] automatically:
                        • Converts from global coordinate space
                        • To proxy's local coordinate space
                        • Returns CGRect you can use directly!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 4: Anchor Example

struct AnchorExampleView: View {
    @State private var highlightLogin = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Anchor Example")
                    .font(.title)
                    .bold()

                GroupBox("Live Demo: Highlighting Button") {
                    VStack(spacing: 15) {
                        VStack(spacing: 20) {
                            Text("Welcome!")
                                .font(.title)

                            VStack(spacing: 15) {
                                Button("Sign Up") {}
                                    .buttonStyle(.bordered)

                                Button("Log In") {}
                                    .buttonStyle(.borderedProminent)
                                    .anchorPreference(
                                        key: HighlightKey.self,
                                        value: .bounds,
                                        transform: { highlightLogin ? $0 : nil }
                                    )
                            }

                            Toggle("Highlight Login", isOn: $highlightLogin)
                                .padding()
                        }
                        .padding()
                        .border(Color.green, width: 2)
                        .overlayPreferenceValue(HighlightKey.self) { anchor in
                            if let anchor = anchor {
                                GeometryReader { proxy in
                                    let rect = proxy[anchor]
                                    Ellipse()
                                        .strokeBorder(Color.red, lineWidth: 3)
                                        .padding(-8)
                                        .frame(width: rect.width, height: rect.height)
                                        .offset(x: rect.origin.x, y: rect.origin.y)
                                }
                            }
                        }

                        Text("""
                        The ellipse is drawn OUTSIDE the VStack (in overlay),
                        but its position is determined by the Login button INSIDE!

                        Anchor propagates position from deep in tree to ancestor.
                        """)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Why This Is Useful")
                            .font(.headline)

                        Text("""
                        Onboarding flows:
                        • Highlight specific UI elements
                        • Draw overlay at top level (not obscured)
                        • Position determined by element deep in tree

                        Without anchors:
                        • Measure in child's coordinate space
                        • Convert to parent's coordinate space
                        • Convert to grandparent's coordinate space
                        • ...repeat for each level...
                        • Error-prone manual math!

                        With anchors:
                        • Measure once (global space)
                        • GeometryProxy auto-converts to local
                        • One line of code: proxy[anchor]
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Anchor Sources")
                            .font(.headline)

                        Text("""
                        Built-in anchor sources on any view:

                        .bounds - Anchor<CGRect>
                        • View's bounding rectangle

                        .center - Anchor<CGPoint>
                        • Center point

                        .top, .bottom, .leading, .trailing - Anchor<CGPoint>
                        • Edge positions

                        .topLeading, .topTrailing, etc. - Anchor<CGPoint>
                        • Corner positions

                        Custom:
                        You can create custom Anchor sources for specific use cases!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("When NOT to Use Anchors")
                            .font(.headline)

                        Text("""
                        Anchors add convenience but also complexity.

                        Skip anchors when:
                        • All views share same parent (use custom coordinate space)
                        • Only measuring, not converting (use GeometryReader directly)
                        • Simple single-view measurements (use overlay + onChange)

                        Use anchors when:
                        • Converting between coordinate spaces at different tree depths
                        • Multiple views at different levels
                        • Complex geometry propagation

                        In our experience: most useful for cross-hierarchy positioning.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Highlight Preference Key

struct HighlightKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?
    static var defaultValue: Value { nil }

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value ?? nextValue()
    }
}

// MARK: - Preview

#Preview {
    TabView {
        CoordinateSpacesView()
            .tabItem { Label("Coordinate Spaces", systemImage: "square.grid.3x3") }

        CustomCoordinateSpacesView()
            .tabItem { Label("Custom Spaces", systemImage: "square.grid.3x3.fill") }

        AnchorsView()
            .tabItem { Label("Anchors", systemImage: "link") }

        AnchorExampleView()
            .tabItem { Label("Example", systemImage: "star.circle") }
    }
}
