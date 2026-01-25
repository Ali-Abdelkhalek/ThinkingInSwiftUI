import SwiftUI

/// Demonstrates Spacer sizing behavior and best practices
struct SpacerBehaviorDemo: View {
    var body: some View {
        TabView {
            SpacerInVStack()
                .tabItem { Label("VStack", systemImage: "1.circle") }

            SpacerInHStack()
                .tabItem { Label("HStack", systemImage: "2.circle") }

            SpacerProblem()
                .tabItem { Label("Problem", systemImage: "3.circle") }

            BetterSolution()
                .tabItem { Label("Solution", systemImage: "4.circle") }

            SpacerDetails()
                .tabItem { Label("Details", systemImage: "5.circle") }
        }
    }
}

// TAB 1: Spacer in VStack
struct SpacerInVStack: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Spacer in VStack")
                .font(.title)
                .bold()
                .padding()

            Text("Behavior:")
                .font(.headline)
            Text("• Flexible HEIGHT (min to infinity)")
            Text("• Reports WIDTH of zero")
            Text("• Pushes content apart vertically")
                .padding(.bottom)

            // Example 1: Single spacer
            VStack(spacing: 0) {
                Text("Top")
                    .padding()
                    .background(Color.blue.opacity(0.3))

                Spacer()
                    .background(Color.red.opacity(0.2))

                Text("Bottom")
                    .padding()
                    .background(Color.green.opacity(0.3))
            }
            .frame(height: 200)
            .border(Color.gray, width: 2)
            .padding()

            Text("Red area = Spacer (fills available height)")
                .font(.caption)
                .foregroundColor(.gray)

            Spacer()

            // Example 2: Multiple spacers
            VStack(spacing: 0) {
                Text("Top")
                    .padding()
                    .background(Color.blue.opacity(0.3))

                Spacer()
                    .background(Color.red.opacity(0.2))

                Text("Middle")
                    .padding()
                    .background(Color.yellow.opacity(0.3))

                Spacer()
                    .background(Color.red.opacity(0.2))

                Text("Bottom")
                    .padding()
                    .background(Color.green.opacity(0.3))
            }
            .frame(height: 200)
            .border(Color.gray, width: 2)
            .padding()

            Text("Multiple spacers share space equally")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom)
        }
    }
}

// TAB 2: Spacer in HStack
struct SpacerInHStack: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Spacer in HStack")
                .font(.title)
                .bold()

            Text("Behavior:")
                .font(.headline)
            Text("• Flexible WIDTH (min to infinity)")
            Text("• Reports HEIGHT of zero")
            Text("• Pushes content apart horizontally")

            // Example 1: Single spacer
            VStack(alignment: .leading, spacing: 10) {
                Text("Right-aligned:")
                    .font(.headline)

                HStack(spacing: 0) {
                    Spacer()
                        .background(Color.red.opacity(0.2))

                    Text("Right")
                        .padding()
                        .background(Color.blue.opacity(0.3))
                }
                .frame(height: 60)
                .border(Color.gray, width: 2)
            }
            .padding()

            // Example 2: Spacers on both sides
            VStack(alignment: .leading, spacing: 10) {
                Text("Centered:")
                    .font(.headline)

                HStack(spacing: 0) {
                    Spacer()
                        .background(Color.red.opacity(0.2))

                    Text("Center")
                        .padding()
                        .background(Color.yellow.opacity(0.3))

                    Spacer()
                        .background(Color.red.opacity(0.2))
                }
                .frame(height: 60)
                .border(Color.gray, width: 2)
            }
            .padding()

            // Example 3: Multiple items
            VStack(alignment: .leading, spacing: 10) {
                Text("Spread out:")
                    .font(.headline)

                HStack(spacing: 0) {
                    Text("L")
                        .padding()
                        .background(Color.blue.opacity(0.3))

                    Spacer()
                        .background(Color.red.opacity(0.2))

                    Text("M")
                        .padding()
                        .background(Color.yellow.opacity(0.3))

                    Spacer()
                        .background(Color.red.opacity(0.2))

                    Text("R")
                        .padding()
                        .background(Color.green.opacity(0.3))
                }
                .frame(height: 60)
                .border(Color.gray, width: 2)
            }
            .padding()

            Spacer()
        }
    }
}

// TAB 3: The Spacer problem
struct SpacerProblem: View {
    let longText = "This is some very long text that should wrap to multiple lines if given enough space to do so properly without truncation"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Spacer Alignment Problem")
                    .font(.title)
                    .bold()

                Text("⚠️ Common but PROBLEMATIC approach:")
                    .font(.headline)
                    .foregroundColor(.red)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Code:")
                        .font(.subheadline)
                        .bold()

                    Text("HStack {\n  Spacer()\n  Text(\"...\")\n}")
                        .font(.caption)
                        .fontDesign(.monospaced)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                    Text("Result:")
                        .font(.subheadline)
                        .bold()

                    HStack {
                        Spacer()
                            .background(Color.red.opacity(0.2))
                        Text(longText)
                            .background(Color.yellow.opacity(0.3))
                    }
                    .border(Color.red, width: 2)

                    Text("❌ THE PROBLEM:")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.red)

                    Text("Spacer has minimum length (≈16pt)\nText starts wrapping/truncating TOO SOON\nSpacer wastes valuable space!")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(8)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(5)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)

                // Show the spacer occupying space
                VStack(alignment: .leading, spacing: 10) {
                    Text("Why this happens:")
                        .font(.headline)

                    Text("1. HStack proposes width to children")
                    Text("2. Spacer takes minimum length (≈16pt)")
                    Text("3. Text gets LESS space than available")
                    Text("4. Text wraps earlier than necessary")

                    HStack(spacing: 0) {
                        Spacer(minLength: 0)
                            .background(Color.red.opacity(0.3))
                            .overlay(
                                Text("Spacer\nwastes\nspace")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            )
                        Text(longText)
                            .background(Color.yellow.opacity(0.3))
                    }
                    .border(Color.gray, width: 1)
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

// TAB 4: Better solution
struct BetterSolution: View {
    let longText = "This is some very long text that should wrap to multiple lines if given enough space to do so properly without truncation"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Better Solution")
                    .font(.title)
                    .bold()

                Text("✅ RECOMMENDED approach:")
                    .font(.headline)
                    .foregroundColor(.green)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Code:")
                        .font(.subheadline)
                        .bold()

                    Text("Text(\"...\")\n  .frame(maxWidth: .infinity,\n         alignment: .trailing)")
                        .font(.caption)
                        .fontDesign(.monospaced)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                    Text("Result:")
                        .font(.subheadline)
                        .bold()

                    Text(longText)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .background(Color.green.opacity(0.3))
                        .border(Color.green, width: 2)

                    Text("✅ BENEFITS:")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.green)

                    Text("No wasted space\nText uses ALL available width\nMore efficient layout")
                        .font(.caption)
                        .foregroundColor(.green)
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)

                // Comparison
                VStack(alignment: .leading, spacing: 10) {
                    Text("Side-by-side comparison:")
                        .font(.headline)

                    Group {
                        Text("❌ HStack + Spacer:")
                            .font(.caption)
                            .bold()
                        HStack {
                            Spacer()
                            Text(longText)
                        }
                        .border(Color.red, width: 2)
                    }

                    Group {
                        Text("✅ .frame(maxWidth:alignment:):")
                            .font(.caption)
                            .bold()
                        Text(longText)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .border(Color.green, width: 2)
                    }

                    Text("Notice: Green solution uses more width,\nwraps less, more efficient!")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                }
                .padding()
                .background(Color.cyan.opacity(0.1))
                .cornerRadius(10)

                // Other alignments
                VStack(alignment: .leading, spacing: 10) {
                    Text("Works for all alignments:")
                        .font(.headline)

                    Text("Leading (left):")
                        .font(.caption)
                    Text("Short text")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                        .background(Color.blue.opacity(0.2))

                    Text("Center:")
                        .font(.caption)
                    Text("Short text")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(8)
                        .background(Color.yellow.opacity(0.2))

                    Text("Trailing (right):")
                        .font(.caption)
                    Text("Short text")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(8)
                        .background(Color.green.opacity(0.2))
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

// TAB 5: Spacer details
struct SpacerDetails: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Spacer Details")
                    .font(.title)
                    .bold()

                Group {
                    Text("Sizing Behavior:")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("• Outside stacks: accepts any size (width & height)")
                        Text("• In VStack: flexible height, zero width")
                        Text("• In HStack: flexible width, zero height")
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }

                Group {
                    Text("Minimum Length:")
                        .font(.headline)

                    Text("Default minimum = default padding (≈16pt)")
                        .padding(8)
                        .background(Color.yellow.opacity(0.3))
                        .cornerRadius(5)

                    Text("Can override with minLength parameter:")
                        .font(.subheadline)

                    Text("Spacer(minLength: 0)")
                        .font(.caption)
                        .fontDesign(.monospaced)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                    HStack {
                        Text("Left")
                            .background(Color.blue.opacity(0.3))
                        Spacer(minLength: 0)
                            .background(Color.red.opacity(0.2))
                        Text("Right")
                            .background(Color.green.opacity(0.3))
                    }
                    .border(Color.gray, width: 1)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)

                Group {
                    Text("When to Use Spacer:")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top) {
                            Text("✅")
                            Text("In stacks when you want flexible spacing")
                        }
                        HStack(alignment: .top) {
                            Text("✅")
                            Text("To push items to edges within stacks")
                        }
                        HStack(alignment: .top) {
                            Text("❌")
                            Text("For simple alignment (use .frame instead)")
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
                }

                Group {
                    Text("Proposed nil behavior:")
                        .font(.headline)

                    Text("When proposed size is nil (infinity), Spacer expands to fill available space up to its maximum")
                        .font(.caption)
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

#Preview {
    SpacerBehaviorDemo()
}
