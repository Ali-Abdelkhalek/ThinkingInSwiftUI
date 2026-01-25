//
//  Transitions.swift
//  ThinkingInSwiftUI
//
//  Chapter 6: Animations - Transitions
//  Animating view insertions and removals
//

import SwiftUI

// MARK: - Tab 1: Understanding Transitions

struct UnderstandingTransitionsView: View {
    @State private var showRect = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Understanding Transitions")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What Are Transitions?")
                            .font(.headline)

                        Text("""
                        Transitions animate views being INSERTED into or REMOVED from the render tree.

                        Unlike property animations (same view, changed properties), transitions handle:
                        • Views added by if/else conditions
                        • Items added/removed from ForEach
                        • Identity changes via .id() modifier

                        Default transition: .opacity (fade in/out)

                        Two States:
                        • Active: Starting state (insertion) or ending state (removal)
                        • Identity: Resting state when view is visible
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Default Transition Demo") {
                    VStack(spacing: 15) {
                        VStack {
                            Button("Toggle") {
                                withAnimation { showRect.toggle() }
                            }
                            .buttonStyle(.bordered)

                            if showRect {
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 100, height: 100)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 140)

                        Text("""
                        Button("Toggle") {
                            withAnimation { flag.toggle() }
                        }

                        if flag {
                            Rectangle()
                                .frame(width: 100, height: 100)
                        }

                        When flag changes:
                        • true: Rectangle fades IN (active opacity 0 → identity opacity 1)
                        • false: Rectangle fades OUT (identity opacity 1 → active opacity 0)

                        This is the default .opacity transition at work!
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
                        Text("How Transitions Work")
                            .font(.headline)

                        Text("""
                        Insertion:
                        1. View starts with ACTIVE state modifiers applied
                        2. Animates toward IDENTITY state
                        3. Ends at identity (normal, visible state)

                        Removal:
                        1. View starts at IDENTITY state (was visible)
                        2. Animates toward ACTIVE state
                        3. Removed from tree after animation completes

                        Example with .opacity transition:
                        • Active: .opacity(0) - invisible
                        • Identity: .opacity(1) - fully visible
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Transitions Need Animations!")
                            .font(.headline)
                            .foregroundColor(.red)

                        Text("""
                        ⚠️ Important: Transitions ONLY work with animations!

                        Just applying .transition doesn't animate anything. You must also use:
                        • withAnimation { } (explicit)
                        • .animation(_:value:) (implicit, placed OUTSIDE the if)

                        ❌ Won't work:
                        if flag {
                            Rectangle()
                                .transition(.scale)
                                .animation(.default, value: flag)  // Inside if!
                        }

                        ✅ Works:
                        VStack {
                            if flag {
                                Rectangle().transition(.scale)
                            }
                        }
                        .animation(.default, value: flag)  // Outside if!

                        Or use withAnimation in the event handler.
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

// MARK: - Tab 2: Built-in Transitions

struct BuiltInTransitionsView: View {
    @State private var showOpacity = true
    @State private var showSlide = true
    @State private var showScale = true
    @State private var showMove = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Built-in Transitions")
                    .font(.title)
                    .bold()

                GroupBox("Opacity") {
                    VStack(spacing: 15) {
                        VStack {
                            Button("Toggle") {
                                withAnimation { showOpacity.toggle() }
                            }
                            .buttonStyle(.bordered)

                            if showOpacity {
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 80, height: 80)
                                    .transition(.opacity)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)

                        Text(".transition(.opacity) - Fades in/out")
                            .font(.caption)
                    }
                    .padding()
                }

                GroupBox("Slide") {
                    VStack(spacing: 15) {
                        VStack {
                            Button("Toggle") {
                                withAnimation { showSlide.toggle() }
                            }
                            .buttonStyle(.bordered)

                            if showSlide {
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: 80, height: 80)
                                    .transition(.slide)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)

                        Text(".transition(.slide) - Slides from leading edge")
                            .font(.caption)
                    }
                    .padding()
                }

                GroupBox("Scale") {
                    VStack(spacing: 15) {
                        VStack {
                            Button("Toggle") {
                                withAnimation { showScale.toggle() }
                            }
                            .buttonStyle(.bordered)

                            if showScale {
                                Rectangle()
                                    .fill(Color.orange)
                                    .frame(width: 80, height: 80)
                                    .transition(.scale)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)

                        Text(".transition(.scale) - Grows/shrinks from center")
                            .font(.caption)
                    }
                    .padding()
                }

                GroupBox("Move") {
                    VStack(spacing: 15) {
                        VStack {
                            Button("Toggle") {
                                withAnimation { showMove.toggle() }
                            }
                            .buttonStyle(.bordered)

                            if showMove {
                                Rectangle()
                                    .fill(Color.purple)
                                    .frame(width: 80, height: 80)
                                    .transition(.move(edge: .bottom))
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)

                        Text(".transition(.move(edge: .bottom)) - Moves from bottom")
                            .font(.caption)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("All Built-in Transitions")
                            .font(.headline)

                        Text("""
                        .opacity - Fade in/out
                        .scale(scale:anchor:) - Grow/shrink
                        .slide - Slide from leading edge
                        .move(edge:) - Slide from specific edge
                        .offset(x:y:) - Move by specific offset
                        .push(from:) - Push content (iOS 16+)

                        Combine them:
                        .scale.combined(with: .opacity)
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

// MARK: - Tab 3: Custom & Combined Transitions

struct CustomTransitionsView: View {
    @State private var showCombined = true
    @State private var showAsymmetric = true
    @State private var showCustom = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Custom & Combined")
                    .font(.title)
                    .bold()

                GroupBox("Combined Transitions") {
                    VStack(spacing: 15) {
                        VStack {
                            Button("Toggle") {
                                withAnimation { showCombined.toggle() }
                            }
                            .buttonStyle(.bordered)

                            if showCombined {
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 80, height: 80)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)

                        Text("""
                        .transition(.scale.combined(with: .opacity))

                        Combines multiple transitions to run simultaneously:
                        • Scales from/to zero
                        • Fades in/out

                        Use .combined(with:) to chain multiple transitions!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox("Asymmetric Transitions") {
                    VStack(spacing: 15) {
                        VStack {
                            Button("Toggle") {
                                withAnimation { showAsymmetric.toggle() }
                            }
                            .buttonStyle(.bordered)

                            if showAsymmetric {
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: 80, height: 80)
                                    .transition(
                                        .asymmetric(
                                            insertion: .move(edge: .leading),
                                            removal: .move(edge: .trailing)
                                        )
                                    )
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)

                        Text("""
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .leading),
                                removal: .move(edge: .trailing)
                            )
                        )

                        Different animations for insertion vs removal:
                        • Insertion: Slides in from left
                        • Removal: Slides out to right

                        Great for directional UI (navigation, sheets, etc.)
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox("Custom Transition") {
                    VStack(spacing: 15) {
                        VStack {
                            Button("Toggle") {
                                withAnimation { showCustom.toggle() }
                            }
                            .buttonStyle(.bordered)

                            if showCustom {
                                Rectangle()
                                    .fill(Color.orange)
                                    .frame(width: 80, height: 80)
                                    .transition(.blur)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 120)

                        Text("""
                        Custom blur transition (pre-iOS 17):

                        struct BlurModifier: ViewModifier {
                            var radius: CGFloat

                            func body(content: Content) -> some View {
                                content.blur(radius: radius)
                            }
                        }

                        extension AnyTransition {
                            static var blur: Self {
                                .modifier(
                                    active: BlurModifier(radius: 10),
                                    identity: BlurModifier(radius: 0)
                                )
                            }
                        }

                        Active state: blur(radius: 10) - very blurry
                        Identity state: blur(radius: 0) - sharp

                        Insertion: Blurs in from blurry → sharp
                        Removal: Blurs out from sharp → blurry
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                if #available(iOS 17, *) {
                    GroupBox {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("iOS 17+ Transition Protocol")
                                .font(.headline)

                            Text("""
                            As of iOS 17, you can conform to the Transition protocol:

                            struct BlurTransition: Transition {
                                var radius: CGFloat

                                func body(content: Content, phase: TransitionPhase)
                                    -> some View {
                                    content.blur(
                                        radius: phase.isIdentity ? 0 : radius
                                    )
                                }
                            }

                            extension Transition where Self == BlurTransition {
                                static func blur(radius: CGFloat) -> Self {
                                    BlurTransition(radius: radius)
                                }
                            }

                            TransitionPhase provides:
                            • .willAppear - Before insertion
                            • .identity - Normal visible state
                            • .didDisappear - After removal

                            Use phase.isIdentity to distinguish states!
                            """)
                            .font(.system(.caption2, design: .monospaced))
                            .padding(8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(5)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

// Custom blur transition
struct BlurModifier: ViewModifier {
    var radius: CGFloat

    func body(content: Content) -> some View {
        content.blur(radius: radius)
    }
}

extension AnyTransition {
    static var blur: Self {
        .modifier(
            active: BlurModifier(radius: 10),
            identity: BlurModifier(radius: 0)
        )
    }
}

// MARK: - Tab 4: Identity Changes

struct IdentityChangesView: View {
    @State private var counter = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Identity Changes")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Transitions Without if/else")
                            .font(.headline)

                        Text("""
                        Transitions aren't only triggered by if/else!

                        Any IDENTITY CHANGE triggers transitions:
                        • Using .id() modifier
                        • ForEach with changing data
                        • Conditional branches swapping

                        When a view's identity changes, SwiftUI treats it as:
                        1. OLD view being REMOVED
                        2. NEW view being INSERTED

                        Even if they look identical in code!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Using .id() to Trigger Transitions") {
                    VStack(spacing: 15) {
                        Text("Counter: \(counter)")
                            .font(.system(size: 40, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                            .transition(.scale.combined(with: .opacity))
                            .id(counter)  // Change identity on counter change!

                        Button("Increment") {
                            withAnimation(.spring()) {
                                counter += 1
                            }
                        }
                        .buttonStyle(.borderedProminent)

                        Text("""
                        Text("\\(counter)")
                            .transition(.scale.combined(with: .opacity))
                            .id(counter)  // Key line!

                        Button("Increment") {
                            withAnimation(.spring()) {
                                counter += 1
                            }
                        }

                        When counter changes:
                        1. Old Text (identity: 0) is REMOVED → transition out
                        2. New Text (identity: 1) is INSERTED → transition in

                        Even though it's the "same" Text view, .id() makes SwiftUI see it as different views!

                        This is a powerful technique for animating content that would otherwise just update without animation.
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
                        Text("When to Use .id() Transitions")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Animating text/number changes")
                                .font(.caption)
                            Text("• Replacing images with transitions")
                                .font(.caption)
                            Text("• Refreshing list content dramatically")
                                .font(.caption)
                            Text("• Creating 'flash' or 'highlight' effects")
                                .font(.caption)
                        }
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Caution")
                            .font(.headline)
                            .foregroundColor(.orange)

                        Text("""
                        Using .id() recreates the entire view and its state!

                        • View initializers run again
                        • @State properties reset
                        • onAppear fires again
                        • Can be expensive for complex views

                        Use sparingly and intentionally.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview

#Preview {
    TabView {
        UnderstandingTransitionsView()
            .tabItem { Label("Understanding", systemImage: "arrow.left.arrow.right") }

        BuiltInTransitionsView()
            .tabItem { Label("Built-in", systemImage: "rectangle.stack") }

        CustomTransitionsView()
            .tabItem { Label("Custom", systemImage: "sparkles") }

        IdentityChangesView()
            .tabItem { Label("Identity", systemImage: "person.badge.key") }
    }
}
