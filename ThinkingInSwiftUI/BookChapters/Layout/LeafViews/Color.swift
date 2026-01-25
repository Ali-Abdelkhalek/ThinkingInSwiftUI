import SwiftUI

/// Comprehensive demo of Color bleed behavior and Safe Area interactions
struct ColorBleedAndSafeArea: View {
    var body: some View {
        TabView {
            // BASICS
            ColorVsRectangle()
                .tabItem { Label("Basics", systemImage: "1.circle") }

            // WHEN DOES BLEED HAPPEN
            WhenDoesBleedHappen()
                .tabItem { Label("When", systemImage: "2.circle") }

            // CHILD VIEWS AT EDGES
            ChildrenAtEdges()
                .tabItem { Label("Children", systemImage: "3.circle") }

            // PADDING BEHAVIOR
            PaddingBehavior()
                .tabItem { Label("Padding", systemImage: "4.circle") }

            // PREVENT BLEED
            PreventBleed()
                .tabItem { Label("Prevent", systemImage: "5.circle") }

            // MEASUREMENTS
            Measurements()
                .tabItem { Label("Measure", systemImage: "6.circle") }
        }
    }
}

// TAB 1: Color bleeds, Rectangle doesn't
struct ColorVsRectangle: View {
    var body: some View {
        HStack(spacing: 0) {
            // Left: Color (bleeds)
            VStack {
                Spacer()
                VStack(spacing: 10) {
                    Text("Color")
                        .font(.title)
                        .bold()
                    Text("BLEEDS")
                        .foregroundColor(.red)
                    Text("into non-safe area")
                        .font(.caption)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.red)

            Divider()

            // Right: Rectangle (doesn't bleed)
            VStack {
                Spacer()
                VStack(spacing: 10) {
                    Text("Rectangle")
                        .font(.title)
                        .bold()
                    Text("NO BLEED")
                        .foregroundColor(.blue)
                    Text("Stops at safe area")
                        .font(.caption)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Rectangle().fill(Color.blue))
        }
    }
}

// TAB 2: Bleed only happens when touching non-safe area
struct WhenDoesBleedHappen: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("When Does Color Bleed?")
                .font(.title)
                .bold()
                .padding(.top)

            Text("Rule: Color bleeds when it touches non-safe area boundaries")
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(10)

            Spacer()

            // Centered box - NO bleed
            VStack {
                Text("Centered Box")
                    .font(.headline)
                Text("Does NOT touch edges")
                Text("→ NO BLEED")
                    .foregroundColor(.green)
            }
            .padding(40)
            .background(Color.green.opacity(0.3))
            .cornerRadius(10)

            Spacer()

            Text("Green doesn't touch screen edges\nso it doesn't bleed")
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cyan.opacity(0.2))
    }
}

// TAB 3: Child views at safe area edges also bleed
struct ChildrenAtEdges: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("TOP TEXT")
                .font(.title)
                .bold()
                .background(Color.yellow)

            Spacer()

            VStack(spacing: 10) {
                Text("Key Discovery!")
                    .font(.title2)
                    .bold()

                Text("The yellow backgrounds BLEED")
                    .foregroundColor(.orange)

                Text("Why?")
                    .font(.headline)

                Text("Because TOP/BOTTOM texts are positioned at safe area edges")
                    .multilineTextAlignment(.center)

                Text("When a view touches the safe area boundary, its Color background bleeds")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .padding()

            Spacer()

            Text("BOTTOM TEXT")
                .font(.title)
                .bold()
                .background(Color.yellow)
        }
        .background(Color.red.opacity(0.3))
    }
}

// TAB 4: Safe area inset vs padding
struct PaddingBehavior: View {
    var body: some View {
        HStack(spacing: 0) {
            // Left: No padding
            VStack(spacing: 0) {
                Text("TOP")
                    .font(.title3)
                    .bold()
                    .background(Color.yellow)

                Spacer()

                VStack {
                    Text("No .padding()")
                        .font(.headline)
                    Text("At safe area edge")
                        .font(.caption)
                }

                Spacer()

                Text("BOTTOM")
                    .font(.title3)
                    .bold()
                    .background(Color.yellow)
            }
            .frame(maxWidth: .infinity)
            .background(Color.red.opacity(0.5))

            Divider()

            // Right: With padding
            VStack(spacing: 0) {
                Text("TOP")
                    .font(.title3)
                    .bold()
                    .background(Color.yellow)

                Spacer()

                VStack {
                    Text("With .padding()")
                        .font(.headline)
                    Text("Safe area + 16pt")
                        .font(.caption)
                }

                Spacer()

                Text("BOTTOM")
                    .font(.title3)
                    .bold()
                    .background(Color.yellow)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.5))
        }
    }
}

// TAB 5: How to prevent bleed
struct PreventBleed: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Prevent Color Bleed")
                .font(.title)
                .bold()
                .padding(.top)

            VStack(alignment: .leading, spacing: 15) {
                Text("Option 1: Use Rectangle")
                    .font(.headline)
                Text(".background(Rectangle().fill(Color.red))")
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)

                Text("Option 2: ignoresSafeAreaEdges")
                    .font(.headline)
                Text(".background(Color.red, ignoresSafeAreaEdges: [])")
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)

                Text("Option 3: Don't touch edges")
                    .font(.headline)
                Text("Keep views away from safe area boundaries with padding/spacing")
                    .font(.caption)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.green,
            ignoresSafeAreaEdges: []  // ← No bleed!
        )
    }
}

// TAB 6: Actual measurements
struct Measurements: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Actual Measurements")
                        .font(.title)
                        .bold()

                    Group {
                        Text("Safe Area Insets:")
                            .font(.headline)
                        Text("• Top: \(Int(geometry.safeAreaInsets.top))pt")
                        Text("• Bottom: \(Int(geometry.safeAreaInsets.bottom))pt")
                        Text("• Leading: \(Int(geometry.safeAreaInsets.leading))pt")
                        Text("• Trailing: \(Int(geometry.safeAreaInsets.trailing))pt")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.yellow.opacity(0.3))
                    .cornerRadius(10)

                    Group {
                        Text("Default .padding():")
                            .font(.headline)
                        Text("• All sides: 16pt (fixed)")
                        Text("• Independent of safe area size")
                        Text("• Added ON TOP of safe area insets")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(10)

                    Group {
                        Text("Key Formulas:")
                            .font(.headline)
                        Text("Total top spacing = \(Int(geometry.safeAreaInsets.top))pt + 16pt = \(Int(geometry.safeAreaInsets.top) + 16)pt")
                        Text("Total bottom spacing = \(Int(geometry.safeAreaInsets.bottom))pt + 16pt = \(Int(geometry.safeAreaInsets.bottom) + 16)pt")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(10)

                    Text("Container frame vs content positioning:")
                        .font(.headline)
                    Text("• Container frame: extends to full screen")
                    Text("• Content layout: within safe area (automatic)")
                    Text("• .padding(): adds extra spacing from safe area edges")

                    Spacer(minLength: 20)
                }
                .padding()
            }
        }
        .background(Color.cyan.opacity(0.1))
    }
}

#Preview {
    ColorBleedAndSafeArea()
}
