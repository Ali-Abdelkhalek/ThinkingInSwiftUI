import SwiftUI

/// Demonstrates Divider sizing behavior in different contexts
struct DividerBehaviorDemo: View {
    var body: some View {
        TabView {
            DividerInVStack()
                .tabItem { Label("VStack", systemImage: "1.circle") }

            DividerInHStack()
                .tabItem { Label("HStack", systemImage: "2.circle") }

            DividerSizing()
                .tabItem { Label("Sizing", systemImage: "3.circle") }

            DividerComparison()
                .tabItem { Label("Compare", systemImage: "4.circle") }
        }
    }
}

// TAB 1: Divider in VStack (horizontal line)
struct DividerInVStack: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Divider in VStack")
                .font(.title)
                .bold()
                .padding()

            Text("Behavior:")
                .font(.headline)
            Text("• Accepts any proposed WIDTH")
            Text("• Reports fixed HEIGHT (1-2pt)")
            Text("• Creates HORIZONTAL line")
                .padding(.bottom)

            Divider()
                .background(Color.red.opacity(0.3))

            VStack(spacing: 20) {
                Text("Section 1")
                    .font(.title2)
                    .foregroundColor(.blue)

                Divider()
                    .background(Color.red.opacity(0.3))

                Text("Section 2")
                    .font(.title2)
                    .foregroundColor(.green)

                Divider()
                    .background(Color.red.opacity(0.3))

                Text("Section 3")
                    .font(.title2)
                    .foregroundColor(.orange)
            }
            .padding()

            Spacer()

            Text("Red background shows divider area")
                .font(.caption)
                .foregroundColor(.gray)
                .padding()
        }
    }
}

// TAB 2: Divider in HStack (vertical line)
struct DividerInHStack: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Divider in HStack")
                .font(.title)
                .bold()

            Text("Behavior:")
                .font(.headline)
            Text("• Accepts any proposed HEIGHT")
            Text("• Reports fixed WIDTH (1-2pt)")
            Text("• Creates VERTICAL line")

            HStack(spacing: 0) {
                VStack {
                    Text("Left")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity)

                Divider()
                    .background(Color.red.opacity(0.3))

                VStack {
                    Text("Center")
                        .font(.title2)
                        .foregroundColor(.green)
                }
                .frame(maxWidth: .infinity)

                Divider()
                    .background(Color.red.opacity(0.3))

                VStack {
                    Text("Right")
                        .font(.title2)
                        .foregroundColor(.orange)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 200)
            .border(Color.gray, width: 1)

            Text("Red background shows divider area")
                .font(.caption)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
    }
}

// TAB 3: Divider sizing details
struct DividerSizing: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Divider Sizing")
                    .font(.title)
                    .bold()

                Group {
                    Text("Outside Stacks:")
                        .font(.headline)

                    Text("Accepts any WIDTH, reports HEIGHT of divider line")

                    VStack(spacing: 10) {
                        Divider()
                            .frame(width: 300)
                            .background(Color.red.opacity(0.3))

                        Text("300pt wide divider")
                            .font(.caption)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }

                Group {
                    Text("Proposing nil:")
                        .font(.headline)

                    Text("Results in default size of 10pt on flexible axis")

                    Text("Example: In HStack with no proposed width, divider width ≈ 10pt")
                        .font(.caption)
                        .padding()
                        .background(Color.yellow.opacity(0.3))
                        .cornerRadius(5)
                }

                Group {
                    Text("Axis Behavior:")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("VStack:")
                                .bold()
                            Text("Flexible width, fixed height")
                        }

                        HStack {
                            Text("HStack:")
                                .bold()
                            Text("Fixed width, flexible height")
                        }

                        HStack {
                            Text("Outside:")
                                .bold()
                            Text("Flexible width, fixed height")
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }

                Group {
                    Text("Visual Test:")
                        .font(.headline)

                    HStack(spacing: 20) {
                        VStack {
                            Text("VStack")
                                .font(.caption)
                            Divider()
                                .frame(height: 100)
                                .background(Color.red)
                        }

                        VStack {
                            Text("HStack")
                                .font(.caption)
                            HStack {
                                Divider()
                                    .background(Color.blue)
                            }
                            .frame(height: 100)
                        }
                    }
                    .padding()
                    .border(Color.gray, width: 1)
                }
            }
            .padding()
        }
    }
}

// TAB 4: Side-by-side comparison
struct DividerComparison: View {
    var body: some View {
        HStack(spacing: 0) {
            // Left: VStack
            VStack(spacing: 0) {
                Text("In VStack")
                    .font(.headline)
                    .padding()

                Text("Item 1")
                    .padding()

                Divider()
                    .background(Color.red)

                Text("Item 2")
                    .padding()

                Divider()
                    .background(Color.red)

                Text("Item 3")
                    .padding()

                Spacer()

                Text("Horizontal lines\n(flexible width)")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.1))

            Divider()
                .background(Color.green)

            // Right: HStack
            VStack(spacing: 0) {
                Text("In HStack")
                    .font(.headline)
                    .padding()

                HStack(spacing: 0) {
                    Text("A")
                        .frame(maxWidth: .infinity)
                        .padding()

                    Divider()
                        .background(Color.red)

                    Text("B")
                        .frame(maxWidth: .infinity)
                        .padding()

                    Divider()
                        .background(Color.red)

                    Text("C")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .frame(height: 150)

                Spacer()

                Text("Vertical lines\n(flexible height)")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color.orange.opacity(0.1))
        }
    }
}

#Preview {
    DividerBehaviorDemo()
}
