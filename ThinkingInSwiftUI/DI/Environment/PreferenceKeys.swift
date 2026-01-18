//
//  PreferenceKeys.swift
//  ThinkingInSwiftUI
//
//  Preference Keys: Data Flowing UPWARD (Child → Parent)
//  The opposite of Environment which flows DOWNWARD (Parent → Child)
//

import SwiftUI

// MARK: - Tab 1: Preference Key Basics

struct PreferenceKeyBasicsExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Preference Keys")
                    .font(.title)
                    .bold()

                Text("Data flowing UPWARD from children to parents")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Environment vs Preference")
                            .font(.headline)

                        HStack(spacing: 20) {
                            VStack(spacing: 8) {
                                Text("Environment")
                                    .font(.caption)
                                    .bold()
                                Text("Parent")
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(4)
                                Image(systemName: "arrow.down")
                                    .foregroundColor(.blue)
                                Text("Child")
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(4)
                                Text("(Downward)")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }

                            VStack(spacing: 8) {
                                Text("Preference")
                                    .font(.caption)
                                    .bold()
                                Text("Parent")
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))
                                    .cornerRadius(4)
                                Image(systemName: "arrow.up")
                                    .foregroundColor(.orange)
                                Text("Child")
                                    .padding(8)
                                    .background(Color.orange.opacity(0.2))
                                    .cornerRadius(4)
                                Text("(Upward)")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Three-Step Pattern")
                            .font(.headline)

                        Text("Step 1: Define the PreferenceKey")
                            .font(.caption)
                            .bold()

                        Text("""
                        struct WidthPreferenceKey: PreferenceKey {
                            static var defaultValue: CGFloat = 0

                            static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
                                value = max(value, nextValue())  // Combine multiple values
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("Step 2: Child sets the preference")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        Text("""
                        Text("Hello")
                            .background(
                                GeometryReader { geo in
                                    Color.clear.preference(
                                        key: WidthPreferenceKey.self,
                                        value: geo.size.width
                                    )
                                }
                            )
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("Step 3: Parent reads the preference")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        Text("""
                        VStack { ... }
                            .onPreferenceChange(WidthPreferenceKey.self) { width in
                                self.maxWidth = width
                            }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The reduce() Function")
                            .font(.headline)

                        Text("When multiple children set the same preference, reduce() combines them:")
                            .font(.caption)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• max(value, nextValue()) - Keep largest")
                                .font(.caption2)
                            Text("• value + nextValue() - Sum all values")
                                .font(.caption2)
                            Text("• value = nextValue() - Last child wins")
                                .font(.caption2)
                            Text("• value.append(nextValue()) - Collect all (for arrays)")
                                .font(.caption2)
                        }
                        .padding(.leading, 8)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Insight")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Preferences are for READING child information")
                                .font(.caption2)
                                .foregroundColor(.orange)
                            Text("• Child sizes and positions")
                                .font(.caption2)
                            Text("• Scroll offsets")
                                .font(.caption2)
                            Text("• Custom values children want to report")
                                .font(.caption2)
                            Text("• Aggregated data from subtrees")
                                .font(.caption2)
                        }

                        Text("NOT for passing data or state management!")
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, 4)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 2: Equal Width Buttons Example

struct EqualWidthButtonsExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Equal Width Buttons")
                    .font(.title)
                    .bold()

                Text("Using preferences to make buttons match the widest one")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Problem")
                            .font(.headline)

                        Text("Buttons have different intrinsic widths:")
                            .font(.caption)

                        VStack(spacing: 10) {
                            Button("OK") { }
                            Button("Cancel") { }
                            Button("Apply Changes") { }
                        }
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.red.opacity(0.1))

                        Text("Looks uneven and unprofessional")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Solution: Preference Key")
                            .font(.headline)

                        Text("Each button reports its width, parent uses the max:")
                            .font(.caption)

                        VStack(spacing: 10) {
                            EqualWidthButton("OK") { }
                            EqualWidthButton("Cancel") { }
                            EqualWidthButton("Apply Changes") { }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .equalWidthHost()

                        Text("All buttons now have equal width")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("How It Works")
                            .font(.headline)

                        Text("""
                        1. Each button measures its intrinsic width
                        2. Reports width via preference key
                        3. reduce() keeps the maximum
                        4. Parent receives max width
                        5. All buttons use that width via environment
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("Data flow: Child → Parent (preference) → Child (environment)")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Implementation")
                            .font(.headline)

                        Text("""
                        struct ButtonWidthKey: PreferenceKey {
                            static var defaultValue: CGFloat? = nil
                            static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
                                if let next = nextValue() {
                                    value = max(value ?? 0, next)
                                }
                            }
                        }

                        struct EqualWidthButton: View {
                            @Environment(\\.equalButtonWidth) var width

                            var body: some View {
                                Button(title, action: action)
                                    .frame(width: width)  // Use shared width
                                    .background(
                                        GeometryReader { geo in
                                            Color.clear.preference(
                                                key: ButtonWidthKey.self,
                                                value: geo.size.width
                                            )
                                        }
                                    )
                            }
                        }
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

// MARK: - Tab 3: Custom Navigation Title

struct CustomNavigationTitleExample: View {
    @State private var currentTitle: String = "Home"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Custom Navigation Title")
                    .font(.title)
                    .bold()

                Text("Child views set the title, parent displays it")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Pattern")
                            .font(.headline)

                        Text("Like .navigationTitle() but custom:")
                            .font(.caption)

                        Text("""
                        // Child sets title
                        ContentView()
                            .customTitle("Settings")

                        // Parent reads and displays
                        CustomNavContainer {
                            ContentView()
                                .customTitle("Settings")
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(spacing: 0) {
                        Text("Live Demo")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 15)

                        CustomNavContainer {
                            VStack(spacing: 20) {
                                Button("Go to Settings") {
                                    currentTitle = "Settings"
                                }

                                Button("Go to Profile") {
                                    currentTitle = "Profile"
                                }

                                Button("Go to Home") {
                                    currentTitle = "Home"
                                }
                            }
                            .customTitle(currentTitle)
                        }
                        .frame(height: 200)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Implementation")
                            .font(.headline)

                        Text("""
                        struct TitlePreferenceKey: PreferenceKey {
                            static var defaultValue: String = ""
                            static func reduce(value: inout String, nextValue: () -> String) {
                                let next = nextValue()
                                if !next.isEmpty { value = next }
                            }
                        }

                        struct CustomNavContainer<Content: View>: View {
                            @State private var title: String = ""
                            let content: Content

                            var body: some View {
                                VStack(spacing: 0) {
                                    // Custom title bar
                                    Text(title)
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)

                                    content
                                }
                                .onPreferenceChange(TitlePreferenceKey.self) { newTitle in
                                    title = newTitle
                                }
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Real-World Uses")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("This is how SwiftUI implements:")
                                .font(.caption)
                            Text("• .navigationTitle()")
                                .font(.caption2)
                            Text("• .toolbar()")
                                .font(.caption2)
                            Text("• .tabItem()")
                                .font(.caption2)
                            Text("• .searchable()")
                                .font(.caption2)
                        }

                        Text("Children declare what they need, containers respond!")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 4)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 4: Scroll Offset Tracking

struct ScrollOffsetTrackingExample: View {
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Scroll Offset Tracking")
                    .font(.title)
                    .bold()

                Text("Children report scroll position to parent")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Technique")
                            .font(.headline)

                        Text("""
                        1. Place invisible view at scroll content top
                        2. Use GeometryReader to get its position
                        3. Report position via preference
                        4. Parent tracks the offset
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Live Demo")
                            .font(.headline)

                        Text("Current offset: \(Int(scrollOffset))")
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(scrollOffset < -50 ? .red : .primary)

                        ScrollView {
                            VStack(spacing: 0) {
                                // Invisible anchor at top
                                Color.clear
                                    .frame(height: 0)
                                    .trackScrollOffset()

                                ForEach(0..<20) { i in
                                    Text("Row \(i)")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(i % 2 == 0 ? Color.blue.opacity(0.1) : Color.clear)
                                }
                            }
                        }
                        .frame(height: 200)
                        .onScrollOffsetChange { offset in
                            scrollOffset = offset
                        }
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)

                        Text("Scroll up to see negative offset")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Implementation")
                            .font(.headline)

                        Text("""
                        struct ScrollOffsetKey: PreferenceKey {
                            static var defaultValue: CGFloat = 0
                            static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
                                value = nextValue()
                            }
                        }

                        extension View {
                            func trackScrollOffset() -> some View {
                                background(
                                    GeometryReader { geo in
                                        Color.clear.preference(
                                            key: ScrollOffsetKey.self,
                                            value: geo.frame(in: .named("scroll")).minY
                                        )
                                    }
                                )
                            }

                            func onScrollOffsetChange(_ action: @escaping (CGFloat) -> Void) -> some View {
                                coordinateSpace(name: "scroll")
                                    .onPreferenceChange(ScrollOffsetKey.self, perform: action)
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Use Cases")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Collapsing headers")
                                .font(.caption2)
                            Text("• Pull-to-refresh indicators")
                                .font(.caption2)
                            Text("• Parallax effects")
                                .font(.caption2)
                            Text("• Sticky headers")
                                .font(.caption2)
                            Text("• Infinite scroll triggers")
                                .font(.caption2)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Tab 5: Anchor Preferences

struct AnchorPreferencesExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Anchor Preferences")
                    .font(.title)
                    .bold()

                Text("Geometry that resolves in parent's coordinate space")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Problem with Regular Preferences")
                            .font(.headline)

                        Text("""
                        Regular preferences report values in the CHILD's
                        coordinate space. But often you need positions
                        relative to an ANCESTOR.

                        Anchor<T> is a token that gets resolved later
                        in whatever coordinate space you need.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Live Demo: Highlight Selected")
                            .font(.headline)

                        HighlightSelectionDemo()
                            .frame(height: 150)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("How Anchor Preferences Work")
                            .font(.headline)

                        Text("""
                        struct BoundsPreferenceKey: PreferenceKey {
                            static var defaultValue: Anchor<CGRect>? = nil
                            static func reduce(value: inout Anchor<CGRect>?,
                                             nextValue: () -> Anchor<CGRect>?) {
                                value = nextValue() ?? value
                            }
                        }

                        // Child reports anchor (not resolved yet)
                        .anchorPreference(key: BoundsPreferenceKey.self,
                                         value: .bounds) { $0 }

                        // Parent resolves in its coordinate space
                        .overlayPreferenceValue(BoundsPreferenceKey.self) { anchor in
                            GeometryReader { geo in
                                if let anchor {
                                    let rect = geo[anchor]  // Resolve here!
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.blue, lineWidth: 2)
                                        .frame(width: rect.width, height: rect.height)
                                        .offset(x: rect.minX, y: rect.minY)
                                }
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("When to Use Anchors")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Use Anchor<CGRect> when:")
                                .font(.caption)
                                .bold()
                            Text("• Drawing overlays relative to children")
                                .font(.caption2)
                            Text("• Animating highlight between items")
                                .font(.caption2)
                            Text("• Custom focus rings")
                                .font(.caption2)
                            Text("• Tooltip positioning")
                                .font(.caption2)
                            Text("• Custom selection indicators")
                                .font(.caption2)
                        }

                        Text("Use regular preference when:")
                            .font(.caption)
                            .bold()
                            .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• You just need a value (width, count, string)")
                                .font(.caption2)
                            Text("• Coordinate space doesn't matter")
                                .font(.caption2)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Implementation Details

// Equal Width Buttons
struct ButtonWidthKey: PreferenceKey {
    static var defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        if let next = nextValue() {
            value = max(value ?? 0, next)
        }
    }
}

struct EqualButtonWidthKey: EnvironmentKey {
    static var defaultValue: CGFloat? = nil
}

extension EnvironmentValues {
    var equalButtonWidth: CGFloat? {
        get { self[EqualButtonWidthKey.self] }
        set { self[EqualButtonWidthKey.self] = newValue }
    }
}

struct EqualWidthButton: View {
    let title: String
    let action: () -> Void
    @Environment(\.equalButtonWidth) var width

    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: width)  // Label expands, button follows
        }
        .buttonStyle(.bordered)
        .background(
            GeometryReader { geo in
                    Color.clear.preference(
                        key: ButtonWidthKey.self,
                        value: geo.size.width
                    )
                }
            )
    }
}

struct EqualWidthHostModifier: ViewModifier {
    @State private var width: CGFloat?

    func body(content: Content) -> some View {
        content
            .onPreferenceChange(ButtonWidthKey.self) { width = $0 }
            .environment(\.equalButtonWidth, width)
    }
}

extension View {
    func equalWidthHost() -> some View {
        modifier(EqualWidthHostModifier())
    }
}

// Custom Navigation Title
struct TitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        let next = nextValue()
        if !next.isEmpty { value = next }
    }
}

struct CustomNavContainer<Content: View>: View {
    @State private var title: String = ""
    @ViewBuilder let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(title.isEmpty ? "Untitled" : title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)

            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(TitlePreferenceKey.self) { newTitle in
            title = newTitle
        }
    }
}

extension View {
    func customTitle(_ title: String) -> some View {
        preference(key: TitlePreferenceKey.self, value: title)
    }
}

// Scroll Offset Tracking
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func trackScrollOffset() -> some View {
        background(
            GeometryReader { geo in
                Color.clear.preference(
                    key: ScrollOffsetKey.self,
                    value: geo.frame(in: .named("scroll")).minY
                )
            }
        )
    }

    func onScrollOffsetChange(_ action: @escaping (CGFloat) -> Void) -> some View {
        coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetKey.self, perform: action)
    }
}

// Anchor Preferences Demo
struct BoundsPreferenceKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>? = nil
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue() ?? value
    }
}

struct HighlightSelectionDemo: View {
    @State private var selectedIndex: Int = 0
    let items = ["Home", "Search", "Profile", "Settings"]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(items.indices, id: \.self) { index in
                Text(items[index])
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        selectedIndex == index
                            ? Color.clear.anchorPreference(
                                key: BoundsPreferenceKey.self,
                                value: .bounds
                            ) { $0 }
                            : nil
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3)) {
                            selectedIndex = index
                        }
                    }
            }
        }
        .overlayPreferenceValue(BoundsPreferenceKey.self) { anchor in
            GeometryReader { geo in
                if let anchor {
                    let rect = geo[anchor]
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: rect.width, height: rect.height)
                        .offset(x: rect.minX, y: rect.minY)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TabView {
        PreferenceKeyBasicsExample()
            .tabItem { Label("Basics", systemImage: "arrow.up.circle") }

        EqualWidthButtonsExample()
            .tabItem { Label("Equal Width", systemImage: "equal.circle") }

        CustomNavigationTitleExample()
            .tabItem { Label("Nav Title", systemImage: "textformat") }

        ScrollOffsetTrackingExample()
            .tabItem { Label("Scroll", systemImage: "scroll") }

        AnchorPreferencesExample()
            .tabItem { Label("Anchors", systemImage: "scope") }
    }
}
