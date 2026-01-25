//
//  PhaseAndKeyframeAnimations.swift
//  ThinkingInSwiftUI
//
//  Chapter 6: Animations - Phase & Keyframe Animations (iOS 17+)
//  Modern approaches to "finish where you started" animations
//

import SwiftUI

// MARK: - Tab 1: Phase Animators

@available(iOS 17, *)
struct PhaseAnimatorsView: View {
    @State private var shakes = 0
    @State private var bounces = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Phase Animators")
                    .font(.title)
                    .bold()

                Text("iOS 17+")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What Are Phase Animators?")
                            .font(.headline)

                        Text("""
                        Phase animators are the EASIEST way to create "finish where you started" animations.

                        Concept:
                        • Define discrete phases (values in an array)
                        • Animator cycles through them sequentially
                        • Each phase transition is a separate animation
                        • Returns to initial phase when done

                        Two modes:
                        • With trigger: Runs once per trigger change
                        • Without trigger: Loops infinitely

                        Phases can be ANY Equatable type:
                        • Ints, Doubles, CGFloats
                        • Enums
                        • Custom structs
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Basic Shake Example") {
                    VStack(spacing: 15) {
                        Button("Shake") { shakes += 1 }
                            .phaseAnimator([0, -20, 20], trigger: shakes) { content, offset in
                                content.offset(x: offset)
                            }
                            .buttonStyle(.borderedProminent)

                        Text("Shakes: \(shakes)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("""
                        Button("Shake") { shakes += 1 }
                            .phaseAnimator([0, -20, 20], trigger: shakes) {
                                content, offset in
                                content.offset(x: offset)
                            }

                        How it works:
                        1. Initial phase: 0 (center)
                        2. Tap button → shakes changes
                        3. Phase 1: 0 → -20 (animate left)
                        4. Phase 2: -20 → 20 (animate right)
                        5. Phase 3: 20 → 0 (animate back to center)
                        6. Done! Waiting for next trigger.

                        Each arrow (→) is a SEPARATE animation.
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("Tip: Try tapping multiple times rapidly!")
                            .font(.caption2)
                            .foregroundColor(.orange)
                    }
                    .padding()
                }

                GroupBox("Custom Timing Per Phase") {
                    VStack(spacing: 15) {
                        Button("Bounce") { bounces += 1 }
                            .phaseAnimator(
                                [0, -30, 0],
                                trigger: bounces
                            ) { content, offset in
                                content.offset(y: offset)
                            } animation: { phase in
                                switch phase {
                                case 0: .spring(response: 0.3, dampingFraction: 0.5)
                                case -30: .spring(response: 0.4, dampingFraction: 0.6)
                                default: .spring()
                                }
                            }
                            .buttonStyle(.borderedProminent)

                        Text("""
                        .phaseAnimator([0, -30, 0], trigger: bounces) {
                            content, offset in
                            content.offset(y: offset)
                        } animation: { phase in
                            switch phase {
                            case 0: .spring(response: 0.3, dampingFraction: 0.5)
                            case -30: .spring(response: 0.4, dampingFraction: 0.6)
                            default: .spring()
                            }
                        }

                        You can customize the animation for EACH phase transition!
                        This allows fine control over timing and feel.
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
                        Text("Phases Don't Interpolate")
                            .font(.headline)
                            .foregroundColor(.orange)

                        Text("""
                        Important: Phase animator doesn't interpolate values!

                        It only cycles through the exact values you provide.
                        The MODIFIERS you apply (offset, opacity, etc.) are what animate.

                        Example:
                        .phaseAnimator([0, 10, 20]) { content, value in
                            content.offset(x: value)
                        }

                        Phase animator gives: 0, then 10, then 20
                        The .offset modifier animates smoothly: 0 → 10 → 20

                        You could use an enum instead of numbers:
                        enum Phase { case start, middle, end }
                        .phaseAnimator([.start, .middle, .end]) { content, phase in
                            switch phase {
                            case .start: content.offset(x: 0)
                            case .middle: content.offset(x: 10)
                            case .end: content.offset(x: 20)
                            }
                        }
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("With vs Without Trigger")
                            .font(.headline)

                        Text("""
                        With trigger:
                        .phaseAnimator([...], trigger: value) { }
                        • Runs once per trigger change
                        • Returns to initial phase and stops
                        • Perfect for user interactions

                        Without trigger:
                        .phaseAnimator([...]) { }
                        • Loops infinitely
                        • Never stops
                        • Perfect for loading indicators, ambient animations

                        Example - Infinite pulse:
                        Circle()
                            .phaseAnimator([1.0, 1.2, 1.0]) { content, scale in
                                content.scaleEffect(scale)
                            }
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

// MARK: - Tab 2: Keyframe Animations Basics

@available(iOS 17, *)
struct KeyframeBasicsView: View {
    @State private var trigger = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Keyframe Animations")
                    .font(.title)
                    .bold()

                Text("iOS 17+")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What Are Keyframe Animations?")
                            .font(.headline)

                        Text("""
                        Keyframe animations provide PRECISE TIMING CONTROL over complex animations.

                        Built on a completely separate subsystem from regular SwiftUI animations!

                        Key concepts:
                        • Keyframes: Discrete target values with durations
                        • Tracks: Independent timelines for different properties
                        • Interpolation: How to move between keyframes

                        Types of keyframes:
                        • LinearKeyframe - Constant speed
                        • CubicKeyframe - Smooth curves (default)
                        • MoveKeyframe - Instant jump to value
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Basic Shake Example") {
                    VStack(spacing: 15) {
                        Button("Shake") { trigger += 1 }
                            .keyframeAnimator(initialValue: 0, trigger: trigger) { content, offset in
                                content.offset(x: offset)
                            } keyframes: { _ in
                                CubicKeyframe(-30, duration: 0.25)
                                CubicKeyframe(30, duration: 0.5)
                                CubicKeyframe(0, duration: 0.25)
                            }
                            .buttonStyle(.borderedProminent)

                        Text("""
                        .keyframeAnimator(initialValue: 0, trigger: trigger) {
                            content, offset in
                            content.offset(x: offset)
                        } keyframes: { _ in
                            CubicKeyframe(-30, duration: 0.25)
                            CubicKeyframe(30, duration: 0.5)
                            CubicKeyframe(0, duration: 0.25)
                        }

                        Timeline (total 1 second):
                        0.00s: offset = 0 (initial)
                        0.25s: offset = -30 (left)
                        0.75s: offset = 30 (right)
                        1.00s: offset = 0 (center)

                        CubicKeyframe creates smooth curves between points.
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
                        Text("Keyframe Types")
                            .font(.headline)

                        Text("""
                        LinearKeyframe(value, duration:)
                        • Constant speed interpolation
                        • Hard transitions at keyframe boundaries
                        • Like .linear timing curve

                        CubicKeyframe(value, duration:)
                        • Smooth Bezier curve interpolation
                        • Considers surrounding keyframes for smoothness
                        • Automatically ramps up/down at boundaries
                        • Like .easeInOut timing curve

                        MoveKeyframe(value)
                        • Instant jump to value
                        • No interpolation
                        • Duration: 0
                        • Like .animation(nil)

                        SpringKeyframe(value, duration:)
                        • Physics-based spring motion
                        • Can overshoot target
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Comparison: Linear vs Cubic")
                            .font(.headline)

                        Text("""
                        LinearKeyframe creates sharp corners:
                        LinearKeyframe(-30, duration: 0.25)
                        LinearKeyframe(30, duration: 0.5)
                        LinearKeyframe(0, duration: 0.25)

                        Path: — → — → —
                        Sharp direction changes at each keyframe.

                        CubicKeyframe creates smooth curves:
                        CubicKeyframe(-30, duration: 0.25)
                        CubicKeyframe(30, duration: 0.5)
                        CubicKeyframe(0, duration: 0.25)

                        Path: ∼ → ∼ → ∼
                        Smooth transitions, considers neighboring keyframes.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("⚠️ Known Issues (at time of writing)")
                            .font(.headline)
                            .foregroundColor(.red)

                        Text("""
                        Keyframe animations still have bugs in iOS 17:

                        • Trigger-based animations may not work correctly on second trigger
                        • Some properties don't animate smoothly
                        • Performance issues with complex keyframes

                        Test thoroughly and have fallback options!

                        Consider using Phase Animators for simpler cases.
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

// MARK: - Tab 3: Multiple Tracks

@available(iOS 17, *)
struct MultipleTracksView: View {
    @State private var trigger = 0

    struct ShakeData {
        var offsetX: CGFloat = 0
        var rotation: Angle = .zero
        var scale: CGFloat = 1
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Multiple Tracks")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Animating Multiple Properties")
                            .font(.headline)

                        Text("""
                        Single value animations are a special case.

                        Generally, keyframe animations let you animate MULTIPLE properties simultaneously using tracks.

                        Each track:
                        • Animates ONE property
                        • Has its own timeline of keyframes
                        • Runs IN PARALLEL with other tracks

                        Example:
                        • Track 1: offset (0 → -30 → 30 → 0)
                        • Track 2: rotation (0° → 20° → -20° → 0°)
                        • Both running at the same time!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Shake + Wobble Example") {
                    VStack(spacing: 15) {
                        Button("Shake & Wobble") { trigger += 1 }
                            .keyframeAnimator(initialValue: ShakeData(), trigger: trigger) { content, data in
                                content
                                    .offset(x: data.offsetX)
                                    .rotationEffect(data.rotation)
                                    .scaleEffect(data.scale)
                            } keyframes: { _ in
                                KeyframeTrack(\.offsetX) {
                                    CubicKeyframe(-30, duration: 0.25)
                                    CubicKeyframe(30, duration: 0.5)
                                    CubicKeyframe(0, duration: 0.25)
                                }

                                KeyframeTrack(\.rotation) {
                                    LinearKeyframe(.degrees(20), duration: 0.2)
                                    LinearKeyframe(.degrees(-20), duration: 0.3)
                                    LinearKeyframe(.degrees(20), duration: 0.3)
                                    LinearKeyframe(.degrees(0), duration: 0.2)
                                }

                                KeyframeTrack(\.scale) {
                                    CubicKeyframe(1.2, duration: 0.15)
                                    CubicKeyframe(0.9, duration: 0.3)
                                    CubicKeyframe(1.0, duration: 0.55)
                                }
                            }
                            .buttonStyle(.borderedProminent)

                        Text("""
                        struct ShakeData {
                            var offsetX: CGFloat = 0
                            var rotation: Angle = .zero
                            var scale: CGFloat = 1
                        }

                        .keyframeAnimator(initialValue: ShakeData(), ...) {
                            content, data in
                            content
                                .offset(x: data.offsetX)
                                .rotationEffect(data.rotation)
                                .scaleEffect(data.scale)
                        } keyframes: { _ in
                            KeyframeTrack(\\.offsetX) {
                                CubicKeyframe(-30, duration: 0.25)
                                CubicKeyframe(30, duration: 0.5)
                                CubicKeyframe(0, duration: 0.25)
                            }

                            KeyframeTrack(\\.rotation) {
                                LinearKeyframe(.degrees(20), duration: 0.2)
                                LinearKeyframe(.degrees(-20), duration: 0.3)
                                LinearKeyframe(.degrees(20), duration: 0.3)
                                LinearKeyframe(.degrees(0), duration: 0.2)
                            }

                            KeyframeTrack(\\.scale) {
                                CubicKeyframe(1.2, duration: 0.15)
                                CubicKeyframe(0.9, duration: 0.3)
                                CubicKeyframe(1.0, duration: 0.55)
                            }
                        }

                        Three tracks running in parallel!
                        Each can have different durations and keyframes.
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
                        Text("Different Track Durations")
                            .font(.headline)

                        Text("""
                        Tracks don't need to have the same duration!

                        If a track ends early:
                        • It reports its FINAL value for the rest of the animation
                        • Other tracks continue running

                        Example:
                        Track 1 (offset): 1 second total
                        Track 2 (rotation): 0.5 seconds total

                        Timeline:
                        0.0 - 0.5s: Both animate
                        0.5 - 1.0s: Only offset animates, rotation stays at final value

                        This allows complex choreography!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Track Order Doesn't Matter")
                            .font(.headline)

                        Text("""
                        Tracks run in PARALLEL, not sequentially.

                        Order in the code doesn't affect timing:
                        KeyframeTrack(\\.rotation) { ... }
                        KeyframeTrack(\\.offset) { ... }

                        Is the same as:
                        KeyframeTrack(\\.offset) { ... }
                        KeyframeTrack(\\.rotation) { ... }

                        Both animations start at t=0 and run simultaneously.
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

// MARK: - Tab 4: Phase vs Keyframe

@available(iOS 17, *)
struct PhaseVsKeyframeView: View {
    @State private var phaseShakes = 0
    @State private var keyframeShakes = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Phase vs Keyframe")
                    .font(.title)
                    .bold()

                GroupBox("Phase Animator") {
                    VStack(spacing: 15) {
                        Button("Shake (Phase)") { phaseShakes += 1 }
                            .phaseAnimator([0, -20, 20], trigger: phaseShakes) { content, offset in
                                content.offset(x: offset)
                            }
                            .buttonStyle(.borderedProminent)

                        Text("""
                        .phaseAnimator([0, -20, 20], trigger: shakes) {
                            content, offset in
                            content.offset(x: offset)
                        }

                        Pros:
                        • Simple, easy to understand
                        • Each phase = separate animation
                        • Can customize animation per phase
                        • Works well for discrete states

                        Cons:
                        • Less precise timing control
                        • Separate animations (not one smooth timeline)
                        • Can't easily create complex choreography
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox("Keyframe Animator") {
                    VStack(spacing: 15) {
                        Button("Shake (Keyframe)") { keyframeShakes += 1 }
                            .keyframeAnimator(initialValue: 0, trigger: keyframeShakes) { content, offset in
                                content.offset(x: offset)
                            } keyframes: { _ in
                                CubicKeyframe(-20, duration: 0.25)
                                CubicKeyframe(20, duration: 0.5)
                                CubicKeyframe(0, duration: 0.25)
                            }
                            .buttonStyle(.borderedProminent)

                        Text("""
                        .keyframeAnimator(initialValue: 0, trigger: shakes) {
                            content, offset in
                            content.offset(x: offset)
                        } keyframes: { _ in
                            CubicKeyframe(-20, duration: 0.25)
                            CubicKeyframe(20, duration: 0.5)
                            CubicKeyframe(0, duration: 0.25)
                        }

                        Pros:
                        • Precise timing control
                        • Single smooth animation timeline
                        • Multiple parallel tracks
                        • Smooth cubic interpolation

                        Cons:
                        • More complex to set up
                        • More code for simple cases
                        • Has known bugs (iOS 17)
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
                        Text("When to Use Each")
                            .font(.headline)

                        Text("""
                        Use Phase Animators when:
                        • Simple discrete states (loading, success, error)
                        • Each phase needs different animation style
                        • You want easy-to-understand code
                        • Animating a single property

                        Use Keyframe Animators when:
                        • Need precise timing control
                        • Animating multiple properties in complex ways
                        • Want smooth cubic curves throughout
                        • Creating complex choreographed animations
                        • Different properties need different timings

                        General rule: Start with Phase, upgrade to Keyframe if needed.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Comparison to Animatable Protocol")
                            .font(.headline)

                        Text("""
                        Pre-iOS 17 approach: Custom Animatable
                        • Works on older iOS
                        • Complete control
                        • More code
                        • Uses linear animation + custom math

                        iOS 17+ Phase/Keyframe:
                        • Easier to use
                        • Built-in support
                        • Better performance (potentially)
                        • More declarative

                        All three approaches solve "finish where you started":
                        • Animatable: Universal, complex
                        • Phase: Simple, discrete
                        • Keyframe: Precise, choreographed
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Limitations")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("• Only available as implicit animations")
                                .font(.caption2)
                            Text("• No withPhaseAnimation or withKeyframeAnimation")
                                .font(.caption2)
                            Text("• Can't animate Color directly (use Color.Resolved)")
                                .font(.caption2)
                            Text("• Keyframes require Animatable values")
                                .font(.caption2)
                            Text("• iOS 17+ only")
                                .font(.caption2)
                        }
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

// MARK: - Preview

#Preview {
    if #available(iOS 17, *) {
        TabView {
            PhaseAnimatorsView()
                .tabItem { Label("Phase", systemImage: "circle.hexagonpath") }

            KeyframeBasicsView()
                .tabItem { Label("Keyframe Basics", systemImage: "waveform.path") }

            MultipleTracksView()
                .tabItem { Label("Multiple Tracks", systemImage: "square.stack.3d.up") }

            PhaseVsKeyframeView()
                .tabItem { Label("Comparison", systemImage: "scale.3d") }
        }
    } else {
        Text("Phase and Keyframe animations require iOS 17+")
            .font(.title3)
            .foregroundColor(.secondary)
    }
}
