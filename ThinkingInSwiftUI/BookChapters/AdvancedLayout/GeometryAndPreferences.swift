//
//  GeometryAndPreferences.swift
//  ThinkingInSwiftUI
//
//  Chapter 7: Advanced Layout - Geometry Readers & Preferences
//  Building layouts without the Layout protocol (iOS 13+)
//

import SwiftUI

// MARK: - Tab 1: GeometryReader Basics

struct GeometryReaderBasicsView: View {
    @State private var showRadius = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("GeometryReader")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What is GeometryReader?")
                            .font(.headline)

                        Text("""
                        GeometryReader measures the PROPOSED SIZE from its parent.

                        Key behaviors:
                        • Unconditionally ACCEPTS the proposed size
                        • Reports that size via GeometryProxy
                        • nil dimensions become 10 points (default)

                        GeometryProxy provides:
                        • .size - The proposed size (CGSize)
                        • .safeAreaInsets - Safe area insets
                        • .frame(in:) - Frame in coordinate space
                        • Anchor resolution
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Common Misconception")
                            .font(.headline)
                            .foregroundColor(.orange)

                        Text("""
                        ❌ "Never use GeometryReader"

                        This sentiment exists because people misunderstand it!

                        Problem: Wrapping a view directly changes layout

                        HStack {
                            Text("A")
                            GeometryReader { proxy in  // ❌ Bad!
                                Text("B")
                            }
                            Text("C")
                        }

                        Text "B" now ACCEPTS proposed size instead of sizing to content.
                        Layout looks completely different!

                        ✅ Solution: Use in overlay/background
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Correct Usage: Overlay/Background") {
                    VStack(spacing: 15) {
                        Text("Hello, World!")
                            .font(.title)
                            .padding()
                            .background {
                                GeometryReader { proxy in
                                    let radius: CGFloat = proxy.size.width > 200 ? 20 : 10
                                    RoundedRectangle(cornerRadius: radius)
                                        .fill(showRadius ? Color.blue : Color.green)
                                }
                            }
                            .onTapGesture { showRadius.toggle() }

                        Text("""
                        Text("Hello, World!")
                            .padding()
                            .background {
                                GeometryReader { proxy in
                                    let radius: CGFloat = proxy.size.width > 200 ? 20 : 10
                                    RoundedRectangle(cornerRadius: radius)
                                        .fill(.blue)
                                }
                            }

                        Overlay/background proposes PRIMARY view's size to secondary.
                        GeometryReader measures without affecting Text's layout!
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
                        Text("Why Overlay/Background Works")
                            .font(.headline)

                        Text("""
                        From Layout chapter:

                        Overlay/background propose the PRIMARY view's size to SECONDARY view.

                        myView                    ← Primary, sizes normally
                            .background {         ← Secondary gets primary's size
                                GeometryReader { proxy in
                                    // proxy.size = myView's size!
                                }
                            }

                        This way:
                        • Primary view sizes as normal (content-based)
                        • GeometryReader measures that size
                        • No layout interference!
                        """)
                        .font(.caption)
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

// MARK: - Tab 2: Measuring Single Views

struct MeasuringSingleViewsView: View {
    @State private var text = "Hello"
    @State private var overflows = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Measuring Single Views")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Challenge")
                            .font(.headline)

                        Text("""
                        GeometryReader is just another view - can't directly assign to @State in its body!

                        ❌ Can't do this:
                        GeometryReader { proxy in
                            size = proxy.size  // Error! Can't mutate in view builder
                            Color.clear
                        }

                        ✅ Solution: Use onAppear + onChange
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Live Example: Overflow Detection") {
                    VStack(spacing: 15) {
                        Text(text)
                            .fixedSize()
                            .overlay {
                                GeometryReader { proxy in
                                    let tooWide = proxy.size.width > 100
                                    Color.clear
                                        .onAppear {
                                            overflows = tooWide
                                        }
                                        .onChange(of: tooWide) { _, newValue in
                                            overflows = newValue
                                        }
                                }
                            }
                            .frame(width: 100)
                            .border(overflows ? Color.red : Color.gray, width: 2)

                        TextField("Type text", text: $text)
                            .textFieldStyle(.roundedBorder)

                        Text(overflows ? "Text overflows!" : "Text fits")
                            .font(.caption)
                            .foregroundColor(overflows ? .red : .green)

                        Text("""
                        @State private var overflows: Bool = false

                        Text(text)
                            .fixedSize()  // Becomes ideal size
                            .overlay {
                                GeometryReader { proxy in
                                    let tooWide = proxy.size.width > 100
                                    Color.clear
                                        .onAppear { overflows = tooWide }
                                        .onChange(of: tooWide) { _, new in
                                            overflows = new
                                        }
                                }
                            }
                            .frame(width: 100)
                            .border(overflows ? .red : .gray)
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
                        Text("Why Both onAppear AND onChange?")
                            .font(.headline)

                        Text("""
                        onAppear:
                        • Fires when node FIRST created
                        • Doesn't fire on subsequent updates

                        onChange:
                        • Fires when value CHANGES
                        • Doesn't fire initially

                        Need both to catch:
                        1. Initial size (onAppear)
                        2. Size changes (onChange)

                        iOS 17+: Use onChange(initial: true)
                        Color.clear
                            .onChange(of: tooWide, initial: true) {
                                overflows = tooWide
                            }
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Helper Extension")
                            .font(.headline)

                        Text("""
                        extension View {
                            func onAppearOrChange<Value: Equatable>(
                                of value: Value,
                                perform: @escaping (Value) -> ()
                            ) -> some View {
                                self
                                    .onAppear { perform(value) }
                                    .onChange(of: value) { _, new in perform(new) }
                            }
                        }

                        Usage:
                        Color.clear
                            .onAppearOrChange(of: tooWide) { overflows = $0 }
                        """)
                        .font(.system(.caption2, design: .monospaced))
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

// MARK: - Tab 3: Preferences

struct PreferencesBasicsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Preferences")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What Are Preferences?")
                            .font(.headline)

                        Text("""
                        Preferences are the COUNTERPART to Environment.

                        Environment: Values flow DOWN the tree (parent → child)
                        Preferences: Values flow UP the tree (child → parent)

                        Use cases:
                        • Measure multiple related views
                        • Communicate from subviews to container
                        • Build custom layout containers
                        • Implement custom navigation-style APIs

                        Example: Flow layout measures ALL subviews, combines into array
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("PreferenceKey Protocol")
                            .font(.headline)

                        Text("""
                        protocol PreferenceKey {
                            associatedtype Value
                            static var defaultValue: Value { get }
                            static func reduce(value: inout Value, nextValue: () -> Value)
                        }

                        You define:
                        1. defaultValue - Initial value if no preference set
                        2. reduce - How to COMBINE values from multiple children

                        Examples:
                        • Max width: reduce takes max of two values
                        • Array of sizes: reduce appends arrays
                        • Optional: reduce takes first non-nil
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: SizeKey")
                            .font(.headline)

                        Text("""
                        Collect sizes from multiple views:

                        struct SizeKey: PreferenceKey {
                            static var defaultValue: [CGSize] = []

                            static func reduce(
                                value: inout [CGSize],
                                nextValue: () -> [CGSize]
                            ) {
                                value.append(contentsOf: nextValue())
                            }
                        }

                        Reduce combines:
                        • value: Current accumulated value
                        • nextValue(): Value from next child
                        • Appends nextValue's array to current array
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Setting Preferences")
                            .font(.headline)

                        Text("""
                        .preference(key:value:)
                        • Sets a preference value
                        • Value bubbles UP the tree

                        Measure a single view:
                        extension View {
                            func measureSize() -> some View {
                                overlay {
                                    GeometryReader { proxy in
                                        Color.clear
                                            .preference(key: SizeKey.self, value: [proxy.size])
                                    }
                                }
                            }
                        }

                        Usage:
                        Text("Hello").measureSize()
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Reading Preferences")
                            .font(.headline)

                        Text("""
                        .onPreferenceChange(_:perform:)
                        • Reads aggregated preference value from subtree
                        • Fires when preference changes

                        ZStack(alignment: .topLeading) {
                            ForEach(0..<5) { ix in
                                Text("Item \\(ix)")
                                    .measureSize()
                            }
                        }
                        .onPreferenceChange(SizeKey.self) { sizes in
                            print(sizes)  // Array of all 5 sizes!
                        }

                        Values bubble up, reduce() combines them.
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 4: Building FlowLayout with Preferences

struct PreferenceFlowLayoutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("FlowLayout with Preferences")
                    .font(.title)
                    .bold()

                Text("iOS 13+ compatible approach")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Strategy")
                            .font(.headline)

                        Text("""
                        Without Layout protocol (pre-iOS 16), we use:
                        1. GeometryReader - Measure container width
                        2. Preferences - Collect subview sizes
                        3. ZStack with alignment guides - Position views

                        More complex than Layout protocol, but works on older iOS!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Live Demo") {
                    ZStackFlowLayoutExample()
                        .frame(width: 250)
                        .border(Color.black)
                        .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Step 1: Measure Container Width")
                            .font(.headline)

                        Text("""
                        ZStack {
                            GeometryReader { proxy in
                                Color.clear
                                    .onAppearOrChange(of: proxy.size.width) {
                                        containerWidth = $0
                                    }
                            }
                            .frame(height: 0)  // Don't affect vertical size

                            ZStackFlowLayout(containerWidth: containerWidth ?? 0)
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }

                        Quirky trick: minWidth: 0, maxWidth: .infinity
                        = "Become exactly the proposed width"
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Step 2: Measure Subviews")
                            .font(.headline)

                        Text("""
                        ForEach(0..<subviewCount) { ix in
                            subview(for: ix)
                                .fixedSize()     // Prevent layout loops!
                                .measureSize()   // Set preference
                        }
                        .onPreferenceChange(SizeKey.self) {
                            sizes = $0
                        }

                        .fixedSize() ensures subview size doesn't depend on what we measure.
                        Without it: infinite layout loop!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Step 3: Position with Alignment Guides")
                            .font(.headline)

                        Text("""
                        let offsets = sizes.map {
                            layout(sizes: $0, containerWidth: containerWidth)
                                .map { $0.origin }
                        } ?? Array(repeating: .zero, count: subviewCount)

                        ZStack(alignment: .topLeading) {
                            ForEach(0..<subviewCount) { ix in
                                subview(for: ix)
                                    .alignmentGuide(.leading) { _ in -offsets[ix].x }
                                    .alignmentGuide(.top) { _ in -offsets[ix].y }
                            }
                        }

                        To move to (100, 50): set leading to -100, top to -50
                        ZStack's size = union of all frames (correct!)
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Why Store Sizes in State?")
                            .font(.headline)

                        Text("""
                        You might think: compute layout directly in onPreferenceChange?

                        ❌ Problem: View won't respond to containerWidth changes!

                        ✅ By storing sizes:
                        Body re-evaluates when:
                        • sizes change (new measurements)
                        • containerWidth changes (window resize)
                        • Environment changes (dynamic type)

                        This ensures proper reactivity!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Common Pitfalls")
                            .font(.headline)
                            .foregroundColor(.red)

                        Text("""
                        1. Missing .fixedSize() → Infinite layout loops
                           Warning: "Bound preference tried to update multiple times"

                        2. Computing offsets in onPreferenceChange → Won't resize

                        3. Forgetting .frame(height: 0) on GeometryReader → Wrong vertical size

                        Subtle bugs! Easy to miss when writing yourself.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Implementations

struct SizeKey: PreferenceKey {
    static var defaultValue: [CGSize] = []
    static func reduce(value: inout [CGSize], nextValue: () -> [CGSize]) {
        value.append(contentsOf: nextValue())
    }
}

extension View {
    func measureSize() -> some View {
        overlay {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SizeKey.self, value: [proxy.size])
            }
        }
    }

    func onAppearOrChange<Value: Equatable>(
        of value: Value,
        perform: @escaping (Value) -> ()
    ) -> some View {
        self
            .onAppear { perform(value) }
            .onChange(of: value) { _, newValue in perform(newValue) }
    }
}

struct ZStackFlowLayoutExample: View {
    @State private var containerWidth: CGFloat?

    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Color.clear
                    .onAppearOrChange(of: proxy.size.width) { containerWidth = $0 }
            }
            .frame(height: 0)

            ZStackFlowLayout(containerWidth: containerWidth ?? 0)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

struct ZStackFlowLayout: View {
    @State private var sizes: [CGSize]? = nil
    var containerWidth: CGFloat
    let subviewCount = 8

    func subview(for index: Int) -> some View {
        Text("Item \(index)")
            .padding(8)
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(hue: .init(index)/Double(subviewCount), saturation: 0.7, brightness: 0.8))
            }
            .foregroundColor(.white)
    }

    var body: some View {
        let offsets = sizes.map {
            layout(sizes: $0, spacing: 8, containerWidth: containerWidth).map { $0.origin }
        } ?? Array(repeating: .zero, count: subviewCount)

        ZStack(alignment: .topLeading) {
            ForEach(0..<subviewCount, id: \.self) { ix in
                subview(for: ix)
                    .fixedSize()
                    .measureSize()
                    .alignmentGuide(.leading) { _ in -offsets[ix].x }
                    .alignmentGuide(.top) { _ in -offsets[ix].y }
            }
        }
        .onPreferenceChange(SizeKey.self) { sizes = $0 }
    }

    func layout(sizes: [CGSize], spacing: CGFloat, containerWidth: CGFloat) -> [CGRect] {
        var result: [CGRect] = []
        var currentPosition: CGPoint = .zero

        func startNewline() {
            guard currentPosition.x != 0 else { return }
            currentPosition.x = 0
            currentPosition.y = result.union().maxY + spacing
        }

        for size in sizes {
            if currentPosition.x + size.width > containerWidth {
                startNewline()
            }
            result.append(CGRect(origin: currentPosition, size: size))
            currentPosition.x += size.width + spacing
        }

        return result
    }
}

// MARK: - Helper Extensions

fileprivate extension [CGRect] {
    func union() -> CGRect {
        guard !isEmpty else { return .zero }
        return reduce(first!) { $0.union($1) }
    }
}

// MARK: - Preview

#Preview {
    TabView {
        GeometryReaderBasicsView()
            .tabItem { Label("GeometryReader", systemImage: "ruler") }

        MeasuringSingleViewsView()
            .tabItem { Label("Single Views", systemImage: "square.dashed") }

        PreferencesBasicsView()
            .tabItem { Label("Preferences", systemImage: "arrow.up.circle") }

        PreferenceFlowLayoutView()
            .tabItem { Label("FlowLayout", systemImage: "rectangle.split.3x1") }
    }
}
