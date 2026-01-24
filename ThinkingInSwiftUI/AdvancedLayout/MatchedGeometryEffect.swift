//
//  MatchedGeometryEffect.swift
//  ThinkingInSwiftUI
//
//  Chapter 7: Advanced Layout - Matched Geometry Effect
//  Smooth transitions between views with matchedGeometryEffect
//

import SwiftUI

// MARK: - Tab 1: Understanding Matched Geometry

struct UnderstandingMatchedGeometryView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Matched Geometry Effect")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What Is It?")
                            .font(.headline)

                        Text("""
                        matchedGeometryEffect gives one or more views (targets) the SAME position, size, or frame as another view (source).

                        Use cases:
                        • Hero transitions between views
                        • Smooth morphing animations
                        • Highlighting/focusing specific elements
                        • Transitioning between list and detail views

                        How it works:
                        1. Measures SOURCE view's position & size
                        2. Proposes same size to TARGET views
                        3. Sets offsets on targets to match position
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Concepts")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 12) {
                            ConceptView(
                                title: "Namespace",
                                description: "@Namespace var namespace - Creates unique identifier for group"
                            )

                            ConceptView(
                                title: "ID",
                                description: "Any Hashable value (String, Int, UUID, etc.)"
                            )

                            ConceptView(
                                title: "Source",
                                description: "One view per group (isSource: true by default)"
                            )

                            ConceptView(
                                title: "Targets",
                                description: "Any number of views (isSource: false)"
                            )
                        }
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Mental Model")
                            .font(.headline)

                        Text("""
                        Think of it as if SwiftUI inserts invisible modifiers:

                        Source view:
                        // No modifications, just measured

                        Target view:
                        .frame(width: <sourceWidth>, height: <sourceHeight>)
                        .offset(x: <offsetX>, y: <offsetY>)

                        Note: This isn't necessarily the implementation,
                        but it's a good mental model!

                        Source size is PROPOSED to target.
                        Target can still refuse (if fixed-size, etc.)
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Requirements")
                            .font(.headline)

                        Text("""
                        For matching to work:

                        ✅ Same namespace
                        ✅ Same ID
                        ✅ Exactly ONE source (isSource: true)
                        ✅ Target must be flexible enough to accept proposed size

                        ❌ Won't work if:
                        • Target has fixed size (non-resizable image, fixed frame)
                        • Different namespaces
                        • Multiple sources with same ID
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

// MARK: - Tab 2: Basic Examples

struct BasicMatchedGeometryView: View {
    @Namespace private var namespace
    @State private var hero = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Basic Examples")
                    .font(.title)
                    .bold()

                GroupBox("Example 1: Highlighting") {
                    VStack(spacing: 15) {
                        VStack(spacing: 20) {
                            Button("Sign Up") {}
                                .buttonStyle(.bordered)

                            Button("Log In") {}
                                .buttonStyle(.borderedProminent)
                                .matchedGeometryEffect(id: "highlight", in: namespace)
                        }
                        .overlay {
                            Ellipse()
                                .strokeBorder(Color.red, lineWidth: 3)
                                .padding(-10)
                                .matchedGeometryEffect(
                                    id: "highlight",
                                    in: namespace,
                                    isSource: false
                                )
                        }
                        .padding()
                        .border(Color.green)

                        Text("""
                        @Namespace private var namespace

                        Button("Log In")
                            .matchedGeometryEffect(id: "highlight", in: namespace)

                        Ellipse()
                            .matchedGeometryEffect(
                                id: "highlight",
                                in: namespace,
                                isSource: false  // Target!
                            )

                        Button is SOURCE (default)
                        Ellipse is TARGET - matches button's size/position
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox("Example 2: Hero Transition") {
                    VStack(spacing: 15) {
                        let circle = Circle().fill(Color.blue)

                        ZStack {
                            if hero {
                                circle
                                    .matchedGeometryEffect(id: "circle", in: namespace)
                            } else {
                                circle
                                    .matchedGeometryEffect(id: "circle", in: namespace)
                                    .frame(width: 60, height: 60)
                                    .padding()
                            }
                        }
                        .frame(height: 300)
                        .border(Color.gray)
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.6)) {
                                hero.toggle()
                            }
                        }

                        Text(hero ? "Fullscreen" : "Small")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("""
                        @State private var hero = false
                        @Namespace private var namespace

                        let circle = Circle().fill(.blue)

                        ZStack {
                            if hero {
                                circle
                                    .matchedGeometryEffect(id: "circle", in: namespace)
                            } else {
                                circle
                                    .matchedGeometryEffect(id: "circle", in: namespace)
                                    .frame(width: 60, height: 60)
                            }
                        }
                        .onTapGesture {
                            withAnimation { hero.toggle() }
                        }

                        Small circle → Fullscreen (and back!)
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
                        Text("How Hero Transition Works")
                            .font(.headline)

                        Text("""
                        Two views, same ID, different branches of if/else.

                        When hero toggles:

                        1. OLD view is REMOVED
                           • Animates from current position
                           • To position it WOULD occupy after state change
                           • (matched to newly inserted source)
                           • While fading out (default transition)

                        2. NEW view is INSERTED
                           • Starts at position OLD view occupied
                           • (matched to old source before state change)
                           • Animates to its final position
                           • While fading in

                        Result: Smooth morph from small → large!
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

// MARK: - Tab 3: Advanced Usage

struct AdvancedMatchedGeometryView: View {
    @Namespace private var namespace
    @State private var selectedID: Int? = nil

    let items = Array(0..<6)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Advanced Usage")
                    .font(.title)
                    .bold()

                GroupBox("Grid to Detail Transition") {
                    VStack(spacing: 15) {
                        if selectedID == nil {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 10) {
                                ForEach(items, id: \.self) { id in
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hue: Double(id) / 6, saturation: 0.7, brightness: 0.8))
                                        .matchedGeometryEffect(id: id, in: namespace)
                                        .frame(height: 80)
                                        .onTapGesture {
                                            withAnimation(.spring(duration: 0.5)) {
                                                selectedID = id
                                            }
                                        }
                                }
                            }
                        } else {
                            VStack(spacing: 20) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(hue: Double(selectedID!) / 6, saturation: 0.7, brightness: 0.8))
                                    .matchedGeometryEffect(id: selectedID!, in: namespace)
                                    .frame(height: 300)

                                Button("Back") {
                                    withAnimation(.spring(duration: 0.5)) {
                                        selectedID = nil
                                    }
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                    }
                    .frame(height: 400)
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Code")
                            .font(.headline)

                        Text("""
                        @Namespace private var namespace
                        @State private var selectedID: Int? = nil

                        if selectedID == nil {
                            // Grid view
                            LazyVGrid(...) {
                                ForEach(items) { id in
                                    ItemView()
                                        .matchedGeometryEffect(id: id, in: namespace)
                                        .onTapGesture { selectedID = id }
                                }
                            }
                        } else {
                            // Detail view
                            ItemView()
                                .matchedGeometryEffect(id: selectedID!, in: namespace)
                            Button("Back") { selectedID = nil }
                        }

                        Each item has unique ID.
                        Only ONE source at a time (the selected item).
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Properties Parameter")
                            .font(.headline)

                        Text("""
                        Control what gets matched:

                        .matchedGeometryEffect(
                            id: "item",
                            in: namespace,
                            properties: .position  // Only position, not size
                        )

                        Options:
                        • .position - Only x/y position
                        • .size - Only width/height
                        • .frame - Both position and size (default)

                        Example use: Keep size independent, only match position
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Anchor Parameter")
                            .font(.headline)

                        Text("""
                        Control alignment point:

                        .matchedGeometryEffect(
                            id: "item",
                            in: namespace,
                            anchor: .topLeading
                        )

                        Default: .center

                        Useful when:
                        • Views have different sizes
                        • Want specific corners to align
                        • Custom alignment behavior
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

// MARK: - Tab 4: Gotchas & Tips

struct MatchedGeometryGotchasView: View {
    @Namespace private var namespace
    @State private var swapped = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Gotchas & Tips")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Modifier Order Matters!")
                            .font(.headline)
                            .foregroundColor(.red)

                        Text("""
                        ❌ Wrong order:
                        Circle()
                            .frame(width: 30, height: 30)
                            .matchedGeometryEffect(id: "circle", in: namespace)

                        Fixed .frame AFTER matching → size always 30×30!
                        Matched geometry has no effect on size.

                        ✅ Correct order:
                        Circle()
                            .matchedGeometryEffect(id: "circle", in: namespace)
                            .frame(width: 30, height: 30)

                        Matching happens first, then .frame applies when needed.

                        Rule: matchedGeometryEffect should be BEFORE size-constraining modifiers!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Order Comparison") {
                    VStack(spacing: 15) {
                        HStack(spacing: 40) {
                            VStack {
                                Text("❌ Wrong")
                                    .font(.caption)
                                    .foregroundColor(.red)

                                Circle()
                                    .fill(swapped ? Color.blue : Color.green)
                                    .frame(width: swapped ? 100 : 50, height: swapped ? 100 : 50)
                                    .matchedGeometryEffect(id: "wrong", in: namespace)
                            }

                            VStack {
                                Text("✅ Correct")
                                    .font(.caption)
                                    .foregroundColor(.green)

                                Circle()
                                    .fill(swapped ? Color.blue : Color.green)
                                    .matchedGeometryEffect(id: "correct", in: namespace)
                                    .frame(width: swapped ? 100 : 50, height: swapped ? 100 : 50)
                            }
                        }
                        .frame(height: 120)

                        Button("Toggle") {
                            withAnimation(.spring(duration: 0.5)) {
                                swapped.toggle()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Target Flexibility")
                            .font(.headline)

                        Text("""
                        Target views must be FLEXIBLE to match source size.

                        Won't work:
                        • Fixed-size images (non-resizable)
                        • .frame(width: X, height: Y) before matching
                        • .fixedSize()

                        Will work:
                        • Shapes (Circle, Rectangle, etc.)
                        • Resizable images
                        • Flexible frames (.frame(maxWidth: .infinity))

                        Tip: Both source and target should have SAME flexibility
                        for best results!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Changing Namespaces/IDs")
                            .font(.headline)

                        Text("""
                        You can dynamically add/remove views from geometry groups:

                        .matchedGeometryEffect(
                            id: isSelected ? "selected" : "unselected",
                            in: namespace
                        )

                        When ID changes:
                        • Removed from old group
                        • Added to new group
                        • Triggers matched geometry animation!

                        Use for:
                        • Selection states
                        • Multi-step transitions
                        • Dynamic grouping
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Could Build It Yourself!")
                            .font(.headline)

                        Text("""
                        matchedGeometryEffect could be implemented using:
                        • Preferences (propagate source geometry up)
                        • Environment (propagate matched geometries down to targets)
                        • View modifier at top level to coordinate

                        SwiftUI does it implicitly for convenience.

                        Understanding this helps demystify the "magic"!
                        No special rendering - just clever use of preferences + environment.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Performance Tips")
                            .font(.headline)

                        Text("""
                        • Use unique namespaces for independent groups
                        • Don't overuse - only for hero transitions
                        • Keep matched views simple
                        • Avoid matching too many properties simultaneously

                        When NOT to use:
                        • Simple size matching (use .frame)
                        • Simple position matching (use .offset)
                        • Non-animated layout (use custom Layout protocol)

                        When to use:
                        • Transitioning between different view hierarchies
                        • Hero animations
                        • View morphing with state changes
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

// MARK: - Helper Views

struct ConceptView: View {
    let title: String
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .bold()
                .foregroundColor(.blue)
            Text(description)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(8)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(5)
    }
}

// MARK: - Preview

#Preview {
    TabView {
        UnderstandingMatchedGeometryView()
            .tabItem { Label("Understanding", systemImage: "arrow.left.arrow.right.circle") }

        BasicMatchedGeometryView()
            .tabItem { Label("Basic Examples", systemImage: "circle.hexagonpath") }

        AdvancedMatchedGeometryView()
            .tabItem { Label("Advanced", systemImage: "square.grid.2x2") }

        MatchedGeometryGotchasView()
            .tabItem { Label("Gotchas & Tips", systemImage: "exclamationmark.triangle") }
    }
}
