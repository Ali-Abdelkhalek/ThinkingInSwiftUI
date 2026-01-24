//
//  AnimationBasics.swift
//  ThinkingInSwiftUI
//
//  Chapter 6: Animations - Basics
//  How animations work, property animations vs transitions
//

import SwiftUI

// MARK: - Tab 1: How Animations Work

struct HowAnimationsWorkView: View {
    @State private var flag = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("How Animations Work")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Core Principle")
                            .font(.headline)

                        Text("""
                        In SwiftUI, the ONLY way to trigger a view update is by changing state.

                        By default, state changes aren't animated. But when you wrap a state change in withAnimation { }, SwiftUI performs these steps:

                        1. Executes the state change
                        2. Rebuilds the view tree with new values
                        3. Compares the new view tree to the current render tree
                        4. Identifies animatable properties that changed
                        5. Interpolates from old values → new values using the timing curve
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Live Example") {
                    VStack(spacing: 15) {
                        Text("Tap the rectangle:")
                            .font(.caption)

                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: flag ? 200 : 50, height: 50)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                withAnimation(.linear(duration: 1)) {
                                    flag.toggle()
                                }
                            }

                        Text("Width animates: \(flag ? "200" : "50") → \(flag ? "50" : "200")")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Code")
                            .font(.headline)

                        Text("""
                        @State private var flag = false

                        Rectangle()
                            .frame(width: flag ? 200 : 50, height: 50)
                            .onTapGesture {
                                withAnimation(.linear(duration: 1)) {
                                    flag.toggle()
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
                        Text("What Happens Internally")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 12) {
                            StepView(
                                step: "1",
                                title: "State changes",
                                description: "flag: false → true"
                            )

                            StepView(
                                step: "2",
                                title: "View tree rebuilt",
                                description: ".frame(width: 200, height: 50)"
                            )

                            StepView(
                                step: "3",
                                title: "Diff detected",
                                description: "width changed: 50 → 200 (animatable!)"
                            )

                            StepView(
                                step: "4",
                                title: "Progress values generated",
                                description: "0% → 25% → 50% → 75% → 100%"
                            )

                            StepView(
                                step: "5",
                                title: "Width values interpolated",
                                description: "50 → 87.5 → 125 → 162.5 → 200"
                            )
                        }
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Progress Values")
                            .font(.headline)

                        Text("""
                        The timing curve generates progress values from 0 to 1.

                        These are used to interpolate animatable properties:

                        value = oldValue + (newValue - oldValue) × progress

                        For width 50 → 200 at progress 0.5:
                        value = 50 + (200 - 50) × 0.5
                        value = 50 + 75 = 125

                        Important: With spring/bouncy curves, progress can overshoot (go beyond 0-1), creating bounce effects!
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

// MARK: - Tab 2: Additive & Cancelable

struct AdditiveAnimationsView: View {
    @State private var position: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Additive & Cancelable")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Principle")
                            .font(.headline)

                        Text("""
                        Animations always start from the CURRENT state of the render tree and move toward the NEW state from the view tree.

                        The "current state" can be:
                        • The resting state (no animation running)
                        • A transient state (mid-animation)

                        This makes SwiftUI animations:

                        • Additive: New animations blend smoothly with running ones
                        • Cancelable: Reversing mid-animation feels natural
                        • Interruptible: User can change direction anytime
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Live Demo") {
                    VStack(spacing: 15) {
                        Text("Try tapping buttons rapidly while animation is running!")
                            .font(.caption)
                            .foregroundColor(.orange)

                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 80)

                            Circle()
                                .fill(Color.blue)
                                .frame(width: 50, height: 50)
                                .offset(x: position)
                        }

                        HStack(spacing: 15) {
                            Button("← Left") {
                                withAnimation(.easeInOut(duration: 1)) {
                                    position = -100
                                }
                            }
                            .buttonStyle(.bordered)

                            Button("Center") {
                                withAnimation(.easeInOut(duration: 1)) {
                                    position = 0
                                }
                            }
                            .buttonStyle(.bordered)

                            Button("Right →") {
                                withAnimation(.easeInOut(duration: 1)) {
                                    position = 100
                                }
                            }
                            .buttonStyle(.bordered)
                        }

                        Text("Notice: No jarring jumps when changing direction mid-animation!")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Why This Matters")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Users can interrupt animations naturally")
                                .font(.caption)
                            Text("• No need to track 'isAnimating' state manually")
                                .font(.caption)
                            Text("• Rapid interactions feel smooth and responsive")
                                .font(.caption)
                            Text("• SwiftUI handles all the math automatically")
                                .font(.caption)
                        }
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example Scenario")
                            .font(.headline)

                        Text("""
                        1. Circle at position 0 (center)
                        2. User taps "Right →"
                           → Animation starts: 0 → 100
                        3. At 50% complete, circle is at position 50
                        4. User taps "Left ←"
                           → New animation starts from CURRENT position (50) → -100
                        5. Result: Smooth reversal, no jump!

                        In other frameworks, you'd need to:
                        • Cancel the first animation
                        • Calculate current position
                        • Start new animation from there

                        SwiftUI does this automatically!
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

// MARK: - Tab 3: Property Animations vs Transitions

struct PropertyVsTransitionView: View {
    @State private var propertyFlag = false
    @State private var transitionFlag = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Property Animations vs Transitions")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Key Distinction")
                            .font(.headline)

                        Text("""
                        Property Animations:
                        Interpolate changed properties of views that EXIST in the tree BEFORE and AFTER the state change.

                        Transitions:
                        Animate views being INSERTED into or REMOVED from the tree.

                        The difference depends entirely on VIEW IDENTITY.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Property Animation") {
                    VStack(spacing: 15) {
                        Text("Same view, property changes:")
                            .font(.caption)

                        Rectangle()
                            .fill(Color.green)
                            .frame(width: propertyFlag ? 200 : 50, height: 50)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    propertyFlag.toggle()
                                }
                            }

                        Text("""
                        Rectangle()
                            .frame(width: flag ? 200 : 50, height: 50)

                        Same .frame modifier exists before & after.
                        Only the width VALUE changes: 50 → 200

                        Result: Width smoothly interpolates
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox("Transition") {
                    VStack(spacing: 15) {
                        Text("Different views (different identities):")
                            .font(.caption)

                        ZStack(alignment: .leading) {
                            if !transitionFlag {
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 50, height: 50)
                            } else {
                                Rectangle()
                                    .fill(Color.orange)
                                    .frame(width: 200, height: 50)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                transitionFlag.toggle()
                            }
                        }

                        Text("""
                        if !flag {
                            rect.frame(width: 50, height: 50)   // View A
                        } else {
                            rect.frame(width: 200, height: 50)  // View B
                        }

                        Different views in ConditionalContent branches!
                        Each has different structural identity.

                        Result: Blue fades out, orange fades in (no interpolation)
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("View Identity Explained")
                            .font(.headline)

                        Text("""
                        SwiftUI tracks views by STRUCTURAL IDENTITY:

                        • Same position in view tree = same view
                        • Different position = different view

                        if/else creates ConditionalContent with TWO branches.
                        Each branch is a different position in the tree.

                        The .frame in the if-branch is NOT the same .frame as in the else-branch, even though they look similar in code!

                        Rule: For property animation, the view must exist BEFORE and AFTER the state change with the same identity.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Two Requirements for Animation")
                            .font(.headline)

                        Text("""
                        For a property to animate, BOTH must be true:

                        1. ✅ Same view identity (before & after state change)
                        2. ✅ Property conforms to VectorArithmetic (can be interpolated)

                        VectorArithmetic means the property can be:
                        • Multiplied by a number: value × 0.5
                        • Added together: oldValue + newValue

                        This is why numbers animate but strings don't!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What's Animatable?")
                            .font(.headline)

                        Text("""
                        Almost all numeric view modifier parameters:

                        Layout:
                        • width, height, padding, offset, position

                        Appearance:
                        • opacity, blur, saturation, brightness
                        • foregroundColor, backgroundColor
                        • scaleEffect, rotationEffect, rotation3DEffect

                        Shape:
                        • cornerRadius, strokeWidth
                        • trim(from:to:)

                        NOT animatable by default:
                        • Text content ("Hello" → "World") - String isn't VectorArithmetic
                        • Image names (SF Symbol changes) - String isn't VectorArithmetic
                        • Font changes - Font type isn't VectorArithmetic
                        • View additions/removals - Different identities (use transitions!)

                        Workaround for text: Animate a number, display as text!
                        Text("\\(Int(count))")  // count: Double animates 0 → 100
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

// MARK: - Helper Views

fileprivate struct StepView: View {
    let step: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(step)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
                .background(Circle().fill(Color.blue))

            VStack(alignment: .leading, spacing: 2) {
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

// MARK: - Preview

#Preview {
    TabView {
        HowAnimationsWorkView()
            .tabItem { Label("How It Works", systemImage: "gearshape.2") }

        AdditiveAnimationsView()
            .tabItem { Label("Additive", systemImage: "plus.circle") }

        PropertyVsTransitionView()
            .tabItem { Label("Animation vs Transition", systemImage: "arrow.triangle.swap") }
    }
}
