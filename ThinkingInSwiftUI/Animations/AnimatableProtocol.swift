//
//  AnimatableProtocol.swift
//  ThinkingInSwiftUI
//
//  Chapter 6: Animations - The Animatable Protocol
//  Custom animatable views and modifiers
//

import SwiftUI

// MARK: - Tab 1: Understanding Animatable

struct UnderstandingAnimatableView: View {
    @State private var flag = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("The Animatable Protocol")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Heart of Property Animation")
                            .font(.headline)

                        Text("""
                        At the heart of SwiftUI's property animation system lies the Animatable protocol.

                        protocol Animatable {
                            var animatableData: VectorArithmetic { get set }
                        }

                        Views and view modifiers adopt this protocol to expose their animatable properties to SwiftUI.

                        VectorArithmetic means:
                        • Can multiply by a scalar (for interpolation)
                        • Can add two values together
                        • Examples: Double, CGFloat, CGPoint, CGSize

                        This allows SwiftUI to interpolate from old → new values!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("How It Works")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 12) {
                            StepView(
                                step: "1",
                                title: "Transaction has animation",
                                description: "withAnimation(.linear) { flag.toggle() }"
                            )

                            StepView(
                                step: "2",
                                title: "SwiftUI traverses tree",
                                description: "Looks for Animatable views/modifiers"
                            )

                            StepView(
                                step: "3",
                                title: "Finds changed animatableData",
                                description: "Opacity changed: 1.0 → 0.3"
                            )

                            StepView(
                                step: "4",
                                title: "Interpolates using timing curve",
                                description: "1.0 → 0.988 → 0.976 → ... → 0.3"
                            )

                            StepView(
                                step: "5",
                                title: "Sets animatableData each frame",
                                description: "Body re-executes 60x per second"
                            )
                        }
                    }
                }

                GroupBox("Example: Opacity Animation") {
                    VStack(spacing: 15) {
                        Text("""
                        When you use .opacity(), SwiftUI's built-in opacity modifier conforms to Animatable:

                        // Simplified version of how .opacity works
                        struct OpacityModifier: ViewModifier, Animatable {
                            var opacity: Double

                            var animatableData: Double {
                                get { opacity }
                                set { opacity = newValue }
                            }

                            func body(content: Content) -> some View {
                                content.opacity(opacity)
                            }
                        }

                        When opacity changes from 1 to 0.3:
                        • animatableData changes from 1.0 to 0.3
                        • SwiftUI interpolates: 1.0 → 0.988 → 0.976 → ... → 0.3
                        • Body re-executes for each interpolated value
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Button("Try It") { flag.toggle() }
                            .opacity(flag ? 1 : 0.3)
                            .animation(.linear(duration: 1), value: flag)
                            .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Usually Transparent")
                            .font(.headline)

                        Text("""
                        Usually, all this happens in the background, and you won't need to conform to Animatable yourself.

                        SwiftUI's built-in modifiers already do:
                        • .opacity, .offset, .frame, .padding
                        • .scaleEffect, .rotationEffect
                        • .foregroundColor, .blur
                        • And many more!

                        But there are cases where implementing custom Animatable views/modifiers is necessary...
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

// MARK: - Tab 2: Custom Animatable Modifier

struct CustomAnimatableModifierView: View {
    @State private var flag = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Custom Animatable Modifier")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Building Our Own Opacity")
                            .font(.headline)

                        Text("""
                        Let's implement an animatable opacity modifier to see what happens behind the scenes:

                        struct MyOpacity: ViewModifier, Animatable {
                            var animatableData: Double

                            init(_ opacity: Double) {
                                animatableData = opacity
                            }

                            func body(content: Content) -> some View {
                                let _ = print(animatableData)  // Log it!
                                return content.opacity(animatableData)
                            }
                        }

                        We're using SwiftUI's .opacity to implement our own, but now we can log the interpolated values!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Live Example") {
                    VStack(spacing: 15) {
                        Text("Watch the console when you tap!")
                            .font(.caption)
                            .foregroundColor(.orange)

                        Button("Animate") { flag.toggle() }
                            .modifier(MyOpacity(flag ? 1 : 0.3))
                            .animation(.linear(duration: 1), value: flag)
                            .buttonStyle(.borderedProminent)

                        Text("""
                        Button("Animate") { flag.toggle() }
                            .modifier(MyOpacity(flag ? 1 : 0.3))
                            .animation(.linear(duration: 1), value: flag)

                        Check the console output:
                        1.0
                        0.988333511352539
                        0.9766663551330566
                        ...
                        0.3233336448669433
                        0.3116664886474609
                        0.3

                        Each value triggers body to re-execute!
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
                        Text("Key Points")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• animatableData is set ~60 times per second during animation")
                                .font(.caption)
                            Text("• Each time it's set, body is re-executed")
                                .font(.caption)
                            Text("• We can use the current value to update the view")
                                .font(.caption)
                            Text("• This is how ALL property animations work in SwiftUI!")
                                .font(.caption)
                        }
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

// Custom opacity modifier for demonstration
struct MyOpacity: ViewModifier, Animatable {
    var animatableData: Double

    init(_ opacity: Double) {
        animatableData = opacity
    }

    func body(content: Content) -> some View {
        let _ = print("MyOpacity animatableData:", animatableData)
        return content.opacity(animatableData)
    }
}

// MARK: - Tab 3: "Finish Where You Started" Animations

struct ShakeAnimationView: View {
    @State private var shakes = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("'Finish Where You Started'")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Problem (Pre-iOS 17)")
                            .font(.headline)

                        Text("""
                        Before iOS 17, there was a challenge:

                        How do you animate something that should end up in the same state it started?

                        Examples:
                        • Shake animation (left → right → center)
                        • Bounce animation (up → down → original position)
                        • Pulse/heartbeat animation

                        Problem: If the view tree doesn't change, there's nothing for SwiftUI to animate!

                        flag ? 100 : 100  // Both sides are the same!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Solution: Custom Animatable Modifier") {
                    VStack(spacing: 15) {
                        Text("""
                        We can use Animatable to create animations that finish where they started:

                        struct Shake: ViewModifier, Animatable {
                            var numberOfShakes: Double

                            var animatableData: Double {
                                get { numberOfShakes }
                                set { numberOfShakes = newValue }
                            }

                            func body(content: Content) -> some View {
                                content.offset(x: -sin(numberOfShakes * 2 * .pi) * 30)
                            }
                        }

                        The magic:
                        • numberOfShakes goes from 0 → 1
                        • sin(0 * 2π) = 0 (start at center)
                        • sin(0.25 * 2π) ≈ 1 (right)
                        • sin(0.5 * 2π) = 0 (center)
                        • sin(0.75 * 2π) ≈ -1 (left)
                        • sin(1 * 2π) = 0 (end at center!)
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox("Live Demo") {
                    VStack(spacing: 15) {
                        Button("Shake!") { shakes += 1 }
                            .modifier(Shake(numberOfShakes: Double(shakes)))
                            .animation(.default, value: shakes)
                            .buttonStyle(.borderedProminent)

                        Text("Shakes: \(shakes)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("""
                        @State private var shakes = 0

                        Button("Shake!") { shakes += 1 }
                            .modifier(Shake(numberOfShakes: Double(shakes)))
                            .animation(.default, value: shakes)

                        How it works:
                        1. User taps → shakes: 0 → 1
                        2. SwiftUI interpolates: 0 → 0.25 → 0.5 → 0.75 → 1
                        3. Sine wave creates: center → right → center → left → center
                        4. Button ends where it started!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)

                        Text("Tap multiple times to shake again!")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("iOS 17+ Alternative")
                            .font(.headline)

                        Text("""
                        As of iOS 17, there are easier ways:
                        • Phase Animators - cycle through discrete phases
                        • Keyframe Animations - precise timing control

                        But understanding Animatable is still valuable:
                        • Gives you complete freedom
                        • Works on older iOS versions
                        • Helps understand how animations work internally
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

// Shake modifier
struct Shake: ViewModifier, Animatable {
    var numberOfShakes: Double

    var animatableData: Double {
        get { numberOfShakes }
        set { numberOfShakes = newValue }
    }

    func body(content: Content) -> some View {
        content.offset(x: -sin(numberOfShakes * 2 * .pi) * 30)
    }
}

// MARK: - Tab 4: More Use Cases

struct MoreUseCasesView: View {
    @State private var progress: Double = 0
    @State private var counter: Int = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("More Animatable Use Cases")
                    .font(.title)
                    .bold()

                GroupBox("Animated Text Counter") {
                    VStack(spacing: 15) {
                        Text("\(Int(progress))")
                            .font(.system(size: 60, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)

                        HStack(spacing: 15) {
                            Button("Count to 100") {
                                withAnimation(.linear(duration: 2)) {
                                    progress = 100
                                }
                            }
                            .buttonStyle(.bordered)

                            Button("Reset") {
                                withAnimation(.linear(duration: 0.5)) {
                                    progress = 0
                                }
                            }
                            .buttonStyle(.bordered)
                        }

                        Text("""
                        You can animate text content by interpolating numbers:

                        @State private var progress: Double = 0

                        Text("\\(Int(progress))")
                            .font(.system(size: 60, weight: .bold))

                        Button("Count") {
                            withAnimation(.linear(duration: 2)) {
                                progress = 100
                            }
                        }

                        SwiftUI animates the Double, we convert to Int for display.
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
                        Text("Custom Timing Curves (Pre-iOS 17)")
                            .font(.headline)

                        Text("""
                        Before iOS 17's CustomAnimation protocol, you could use Animatable to create custom timing curves:

                        struct ElasticModifier: ViewModifier, Animatable {
                            var progress: Double

                            var animatableData: Double {
                                get { progress }
                                set { progress = newValue }
                            }

                            func body(content: Content) -> some View {
                                let elasticity = sin(progress * .pi * 3) * (1 - progress)
                                let adjustedProgress = progress + elasticity * 0.3
                                content.offset(x: adjustedProgress * 200)
                            }

                            func customCurve(_ t: Double) -> Double {
                                // Your custom math here
                                return t + sin(t * .pi * 4) * (1 - t) * 0.2
                            }
                        }

                        Use a LINEAR animation, then apply custom curve inside:
                        .modifier(ElasticModifier(progress: flag ? 1 : 0))
                        .animation(.linear(duration: 1), value: flag)

                        The linear animation interpolates progress 0 → 1,
                        your custom math creates the elastic effect!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Multiple Animatable Values")
                            .font(.headline)

                        Text("""
                        For more than one value, use AnimatablePair:

                        struct TwoValueModifier: ViewModifier, Animatable {
                            var value1: Double
                            var value2: Double

                            var animatableData: AnimatablePair<Double, Double> {
                                get {
                                    AnimatablePair(value1, value2)
                                }
                                set {
                                    value1 = newValue.first
                                    value2 = newValue.second
                                }
                            }

                            func body(content: Content) -> some View {
                                content
                                    .offset(x: value1)
                                    .opacity(value2)
                            }
                        }

                        SwiftUI interpolates both values simultaneously!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Common Pitfall")
                            .font(.headline)
                            .foregroundColor(.red)

                        Text("""
                        ⚠️ Don't forget the implementation!

                        // ❌ Won't work - uses default implementation
                        struct MyModifier: ViewModifier, Animatable {
                            var value: Double
                            // Missing animatableData!
                        }

                        // ✅ Correct
                        struct MyModifier: ViewModifier, Animatable {
                            var value: Double

                            var animatableData: Double {
                                get { value }
                                set { value = newValue }
                            }
                        }

                        The protocol has a default implementation of EmptyAnimatableData, so the compiler won't complain, but your animation won't work!
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

// MARK: - Helper Views
// StepView now imported from DesignSystem/Components/StepView.swift

// MARK: - Preview

#Preview {
    TabView {
        UnderstandingAnimatableView()
            .tabItem { Label("Understanding", systemImage: "star.circle") }

        CustomAnimatableModifierView()
            .tabItem { Label("Custom Modifier", systemImage: "square.and.pencil") }

        ShakeAnimationView()
            .tabItem { Label("Shake Animation", systemImage: "waveform") }

        MoreUseCasesView()
            .tabItem { Label("More Use Cases", systemImage: "list.bullet") }
    }
}
