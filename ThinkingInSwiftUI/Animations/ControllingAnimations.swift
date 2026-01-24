//
//  ControllingAnimations.swift
//  ThinkingInSwiftUI
//
//  Chapter 6: Animations - Controlling Animations
//  Implicit vs explicit animations, timing curves, transactions
//

import SwiftUI

// MARK: - Tab 1: Implicit vs Explicit

struct ImplicitVsExplicitView: View {
    @State private var implicitFlag = false
    @State private var explicitFlag = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Implicit vs Explicit Animations")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Two Ways to Animate")
                            .font(.headline)

                        HStack(alignment: .top, spacing: 15) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Implicit")
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(.blue)
                                Text("\"When this VALUE changes\"")
                                    .font(.caption2)
                                    .italic()
                                Text(".animation(_:value:)")
                                    .font(.system(.caption2, design: .monospaced))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Explicit")
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(.orange)
                                Text("\"When this EVENT happens\"")
                                    .font(.caption2)
                                    .italic()
                                Text("withAnimation { }")
                                    .font(.system(.caption2, design: .monospaced))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }

                GroupBox("Implicit Animation") {
                    VStack(spacing: 15) {
                        Text("""
                        Scoped to VIEW SUBTREE + VALUE
                        • Animates when value changes, regardless of source
                        • Limited to specific part of view hierarchy
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)

                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: implicitFlag ? 150 : 50, height: 50)
                            .animation(.spring(), value: implicitFlag)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Button("Toggle") { implicitFlag.toggle() }
                            .buttonStyle(.bordered)

                        Text("""
                        Rectangle()
                            .frame(width: flag ? 150 : 50, height: 50)
                            .animation(.spring(), value: flag)
                            .onTapGesture { flag.toggle() }

                        The .animation modifier applies to its SUBTREE.
                        Animates whenever flag changes.

                        Important: Place .animation as locally as possible!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox("Explicit Animation") {
                    VStack(spacing: 15) {
                        Text("""
                        Scoped to STATE CHANGE
                        • Animates all changes from that event
                        • Can distinguish user action vs model update
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)

                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: explicitFlag ? 150 : 50, height: 50)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Button("Toggle") {
                            withAnimation(.spring()) {
                                explicitFlag.toggle()
                            }
                        }
                        .buttonStyle(.bordered)

                        Text("""
                        Rectangle()
                            .frame(width: flag ? 150 : 50, height: 50)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    flag.toggle()
                                }
                            }

                        withAnimation wraps the STATE CHANGE.
                        Only this specific event triggers animation.
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
                        Text("When to Use Which?")
                            .font(.headline)

                        Text("""
                        Use Implicit When:
                        • You want to animate regardless of what caused the change
                        • Model updates should animate the same as user actions
                        • You need precise control over which views animate

                        Use Explicit When:
                        • Only user-triggered changes should animate
                        • Server/model updates should NOT animate
                        • You have access to the event callback

                        Example:
                        // User tap → animate
                        Button("Add") {
                            withAnimation { items.append(newItem) }
                        }

                        // Server push → NO animation
                        func onDataReceived(_ newItems: [Item]) {
                            items = newItems  // No withAnimation
                        }

                        Explicit animations let you distinguish these cases!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Deprecated .animation(_:)")
                            .font(.headline)
                            .foregroundColor(.red)

                        Text("""
                        ❌ Old (deprecated):
                        .animation(.default)

                        This applied animations too broadly, causing unexpected behavior (e.g., animating on device orientation changes).

                        ✅ Modern:
                        .animation(.default, value: someValue)

                        The value parameter restricts scope - crucial for control!
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

// MARK: - Tab 2: Binding & Scoped Animations

struct BindingAndScopedAnimationsView: View {
    @State private var bindingFlag = false
    @State private var scopedFlag = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Binding & Scoped Animations")
                    .font(.title)
                    .bold()

                GroupBox("Binding Animation") {
                    VStack(spacing: 15) {
                        Text("""
                        Call .animation() on a Binding to wrap its setter in an explicit animation.

                        Useful when:
                        • You don't have access to the event closure
                        • You want animation without modifying child view
                        • Using system controls (Toggle, Slider, etc.)
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)

                        AnimatedRect(flag: $bindingFlag.animation(.spring()))

                        Text("""
                        struct AnimatedRect: View {
                            @Binding var flag: Bool

                            var body: some View {
                                Rectangle()
                                    .frame(width: flag ? 150 : 50, height: 50)
                                    .onTapGesture { flag.toggle() }
                            }
                        }

                        // Parent applies animation via binding
                        AnimatedRect(flag: $flag.animation(.spring()))

                        Child view has NO animation code!
                        Parent controls animation through the binding.
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        Text("With System Controls:")
                            .font(.caption)
                            .bold()
                            .padding(.top)

                        Toggle("Expand", isOn: $bindingFlag.animation(.spring()))
                            .padding(.horizontal)

                        Text("""
                        Toggle(isOn: $flag.animation(.spring()))

                        No need to wrap Toggle's internal action!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                if #available(iOS 17, *) {
                    GroupBox("Scoped Animation (iOS 17+)") {
                        VStack(spacing: 15) {
                            Text("""
                            .animation(_:body:) lets you animate ONLY specific modifiers.

                            Modifiers INSIDE the closure animate.
                            Modifiers OUTSIDE do NOT animate.
                            """)
                            .font(.caption)
                            .padding(8)
                            .background(Color.purple.opacity(0.1))
                            .cornerRadius(5)

                            Text("Hello")
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .opacity(scopedFlag ? 1 : 0.3)  // NOT animated
                                .animation(.spring(duration: 0.8)) {
                                    $0.rotationEffect(scopedFlag ? .zero : .degrees(180))
                                }
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .onTapGesture { scopedFlag.toggle() }

                            Text("Tap: Opacity jumps, rotation animates")
                                .font(.caption2)
                                .foregroundColor(.secondary)

                            Text("""
                            Text("Hello")
                                .opacity(flag ? 1 : 0.3)      // NOT animated
                                .animation(.spring()) {
                                    $0.rotationEffect(...)     // Animated!
                                }

                            Equivalent to (pre-iOS 17):
                            Text("Hello")
                                .opacity(flag ? 1 : 0.3)
                                .animation(nil, value: flag)    // Block
                                .rotationEffect(...)
                                .animation(.spring(), value: flag)  // Enable
                            """)
                            .font(.system(.caption2, design: .monospaced))
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(5)

                            Text("""
                            ⚠️ Pitfalls:
                            1. No value parameter - always animates when parameters change
                            2. Some modifiers (.frame, .offset, .foregroundColor) may not work as expected inside the body closure
                            """)
                            .font(.caption2)
                            .foregroundColor(.red)
                            .padding(8)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(5)
                        }
                        .padding()
                    }
                }
            }
            .padding()
        }
    }
}

struct AnimatedRect: View {
    @Binding var flag: Bool

    var body: some View {
        Rectangle()
            .fill(Color.green)
            .frame(width: flag ? 150 : 50, height: 50)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture { flag.toggle() }
    }
}

// MARK: - Tab 3: Timing Curves

struct TimingCurvesView: View {
    @State private var animate = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Timing Curves")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Built-in Curves")
                            .font(.headline)

                        Text("""
                        A timing curve (easing function) controls HOW progress changes from 0 to 1 over time.

                        SwiftUI provides:
                        • .linear(duration:) - Constant speed
                        • .easeIn(duration:) - Slow start, fast end
                        • .easeOut(duration:) - Fast start, slow end
                        • .easeInOut(duration:) - Slow at both ends
                        • .spring(...) - Physics-based with bounce

                        Default: .spring(response: 0.55, dampingFraction: 1)
                        This is why SwiftUI feels bouncy by default!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("Live Comparison") {
                    VStack(spacing: 15) {
                        TimingRow(name: "Linear", color: .blue, animation: .linear(duration: 1), animate: animate)
                        TimingRow(name: "EaseIn", color: .green, animation: .easeIn(duration: 1), animate: animate)
                        TimingRow(name: "EaseOut", color: .orange, animation: .easeOut(duration: 1), animate: animate)
                        TimingRow(name: "EaseInOut", color: .purple, animation: .easeInOut(duration: 1), animate: animate)
                        TimingRow(name: "Spring", color: .red, animation: .spring(response: 0.5, dampingFraction: 0.6), animate: animate)

                        Button(animate ? "Reset" : "Animate") {
                            animate.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Animation Modifiers")
                            .font(.headline)

                        Text("""
                        Chain modifiers to control timing:

                        .speed(_:)
                        Multiplies speed by a factor:
                        .linear(duration: 1).speed(0.5)  // Takes 2 seconds
                        .linear(duration: 1).speed(2)    // Takes 0.5 seconds

                        .delay(_:)
                        Delays animation start:
                        .spring().delay(0.2)  // Starts after 0.2s

                        .repeatCount(_:autoreverses:)
                        Loops animation:
                        .linear(duration: 1).repeatCount(3)
                        .linear(duration: 1).repeatCount(3, autoreverses: true)

                        Combine them:
                        .easeInOut(duration: 1)
                            .speed(0.5)
                            .delay(0.2)
                            .repeatCount(2, autoreverses: true)
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Spring Parameters")
                            .font(.headline)

                        Text("""
                        .spring(response: dampingFraction: blendDuration:)

                        response: How quickly spring responds
                        • Lower = faster (0.3 = tight)
                        • Higher = slower (1.0 = sluggish)

                        dampingFraction: Bounciness (0-1+)
                        • 0 = endless oscillation
                        • 0.5-0.7 = bouncy
                        • 1.0 = no overshoot (critically damped)

                        iOS 17+ convenience:
                        .bouncy(duration:extraBounce:)
                        .smooth(duration:extraBounce:)
                        .snappy(duration:extraBounce:)
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

struct TimingRow: View {
    let name: String
    let color: Color
    let animation: Animation
    let animate: Bool

    var body: some View {
        HStack(spacing: 12) {
            Text(name)
                .font(.caption)
                .frame(width: 70, alignment: .leading)

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 30)

                Circle()
                    .fill(color)
                    .frame(width: 25, height: 25)
                    .offset(x: animate ? 200 : 0)
                    .animation(animation, value: animate)
            }
        }
    }
}

// MARK: - Tab 4: Transactions

struct TransactionsView: View {
    @State private var explicitFlag = false
    @State private var transactionFlag = false
    @State private var precedenceFlag = false
    @State private var disabledFlag = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Transactions")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What Are Transactions?")
                            .font(.headline)

                        Text("""
                        Every view update is wrapped in a Transaction.

                        Transaction carries:
                        • animation: The animation to apply (or nil)
                        • disablesAnimations: Whether to block implicit animations
                        • Custom keys (iOS 17+): Additional metadata

                        By default: transaction.animation = nil (no animation)

                        Both withAnimation and .animation() work by setting the transaction's animation property!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox("withAnimation = Transaction") {
                    VStack(spacing: 15) {
                        Text("These are equivalent:")
                            .font(.caption)

                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: explicitFlag ? 150 : 50, height: 40)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Button("Animate") {
                            withAnimation(.spring()) {
                                explicitFlag.toggle()
                            }
                        }
                        .buttonStyle(.bordered)

                        Text("""
                        // Using withAnimation
                        withAnimation(.spring()) {
                            flag.toggle()
                        }

                        // Using withTransaction directly
                        var t = Transaction(animation: .spring())
                        withTransaction(t) {
                            flag.toggle()
                        }

                        They do the exact same thing!
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox(".transaction Modifier") {
                    VStack(spacing: 15) {
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: transactionFlag ? 150 : 50, height: 40)
                            .transaction { t in
                                t.animation = .spring()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture { transactionFlag.toggle() }

                        Text("Tap the rectangle above")
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        Text("""
                        Rectangle()
                            .frame(width: flag ? 150 : 50, height: 50)
                            .transaction { t in
                                t.animation = .spring()
                            }
                            .onTapGesture { flag.toggle() }

                        Like implicit animation, passes down the tree.

                        ⚠️ Limitation: No value parameter
                        Behaves like deprecated .animation(_:) - animates ALL changes!
                        Prefer .animation(_:value:) for most cases.
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox("Animation Precedence") {
                    VStack(spacing: 15) {
                        Text("""
                        Implicit animations OVERRIDE explicit animations!

                        Why? Execution order:
                        1. withAnimation sets transaction.animation
                        2. View tree is evaluated
                        3. .animation modifier executes later, OVERRIDING

                        The last .animation wins.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(5)

                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: precedenceFlag ? 150 : 50, height: 40)
                            .animation(.spring(), value: precedenceFlag)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Button("Tap (uses spring, not linear!)") {
                            withAnimation(.linear(duration: 2)) {
                                precedenceFlag.toggle()
                            }
                        }
                        .buttonStyle(.bordered)

                        Text("""
                        .animation(.spring(), value: flag)  // This wins!
                        .onTapGesture {
                            withAnimation(.linear(duration: 2)) {  // Ignored
                                flag.toggle()
                            }
                        }
                        """)
                        .font(.system(.caption2, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                    .padding()
                }

                GroupBox("disablesAnimations") {
                    VStack(spacing: 15) {
                        Text("""
                        To prevent implicit animations from overriding, use:
                        transaction.disablesAnimations = true

                        This BLOCKS implicit animations!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(5)

                        Rectangle()
                            .fill(Color.purple)
                            .frame(width: disabledFlag ? 150 : 50, height: 40)
                            .animation(.spring(), value: disabledFlag)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Button("Tap (linear wins!)") {
                            var t = Transaction(animation: .linear(duration: 2))
                            t.disablesAnimations = true
                            withTransaction(t) {
                                disabledFlag.toggle()
                            }
                        }
                        .buttonStyle(.borderedProminent)

                        Text("""
                        How .animation works (conceptually):
                        extension View {
                            func animation(_ animation: Animation?) -> some View {
                                transaction { t in
                                    guard !t.disablesAnimations else { return }
                                    t.animation = animation
                                }
                            }
                        }

                        If disablesAnimations is true, it does nothing!
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
                        Text("Removing Animations")
                            .font(.headline)

                        Text("""
                        Pre-deprecation:
                        .animation(nil)  // Worked, now deprecated

                        Modern approach:
                        .transaction { $0.animation = nil }

                        This removes animation for the subtree.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                if #available(iOS 17, *) {
                    GroupBox {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Extensible Transactions (iOS 17+)")
                                .font(.headline)

                            Text("""
                            Like EnvironmentKey, you can define custom TransactionKeys:

                            struct ChangeSourceKey: TransactionKey {
                                static var defaultValue: ChangeSource = .unknown
                            }

                            extension Transaction {
                                var changeSource: ChangeSource {
                                    get { self[ChangeSourceKey.self] }
                                    set { self[ChangeSourceKey.self] = newValue }
                                }
                            }

                            Use case: Distinguish user actions from server updates
                            // User action → animate
                            var t = Transaction(animation: .spring())
                            t.changeSource = .user
                            withTransaction(t) { items.append(newItem) }

                            // Server update → NO animation
                            var t = Transaction()
                            t.changeSource = .server
                            withTransaction(t) { items = serverData }
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

// MARK: - Preview

#Preview {
    TabView {
        ImplicitVsExplicitView()
            .tabItem { Label("Implicit vs Explicit", systemImage: "slider.horizontal.3") }

        BindingAndScopedAnimationsView()
            .tabItem { Label("Binding & Scoped", systemImage: "link") }

        TimingCurvesView()
            .tabItem { Label("Timing Curves", systemImage: "waveform") }

        TransactionsView()
            .tabItem { Label("Transactions", systemImage: "arrow.triangle.branch") }
    }
}
