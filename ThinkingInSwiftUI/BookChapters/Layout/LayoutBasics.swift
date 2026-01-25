//
//  LayoutBasics.swift
//  ThinkingInSwiftUI
//
//  Chapter 4: Layout - Understanding the Layout Algorithm
//  The foundation of SwiftUI's layout system
//

import SwiftUI

// MARK: - Tab 1: The Layout Algorithm

struct LayoutAlgorithmView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("The Layout Algorithm")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("How SwiftUI's Layout Works")
                            .font(.headline)

                        Text("""
                        SwiftUI's layout algorithm is straightforward:

                        1. Parent proposes a size to child
                        2. Child determines its own size (based on proposal)
                        3. Child reports size back to parent
                        4. Parent places child

                        The goal: Give each view a position and a size.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: VStack with Image and Text")
                            .font(.headline)

                        VStack(spacing: 10) {
                            Image(systemName: "globe")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                            Text("Hello, World!")
                        }
                        .padding()
                        .border(Color.blue, width: 2)

                        Text("""
                        Layout Steps:

                        1. Window proposes safe area size to VStack
                        2. VStack proposes size to Image
                           → Image reports its size (based on globe symbol)
                        3. VStack proposes size to Text
                           → Text reports its size (based on string)
                        4. VStack places subviews beneath each other
                        5. VStack computes own size (union of frames)
                        6. VStack reports back to window
                        """)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("The Four Steps (Formal)")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            StepView(
                                step: "1",
                                title: "Parent proposes a size",
                                description: "Container asks: 'I have this much space, how big do you want to be?'"
                            )

                            StepView(
                                step: "2",
                                title: "Child determines its size",
                                description: "Recursively starts at step 1 if it has subviews"
                            )

                            StepView(
                                step: "3",
                                title: "Child reports size",
                                description: "This is DEFINITIVE - parent cannot change it unilaterally"
                            )

                            StepView(
                                step: "4",
                                title: "Parent places child",
                                description: "Using alignment and child's alignment guides"
                            )
                        }
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Principle")
                            .font(.headline)

                        Text("The size reported by the subview in step 3 is the DEFINITIVE size. The parent cannot alter this size unilaterally. It could propose a different size (go back to step 2), but at the end of the day, the subview determines its own size.")
                            .font(.caption)
                            .padding(8)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(5)

                        Text("This is why sometimes views render 'out of bounds' - the child can report a larger size than proposed, and the parent must accept it!")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Detailed Example")
                            .font(.headline)

                        Text("Favorite")
                            .padding(10)
                            .background(Color.teal)
                            .border(Color.red, width: 2)

                        Text("""
                        Code:
                        Text("Favorite")
                            .padding(10)
                            .background(Color.teal)

                        Window size: 320×480

                        Steps:
                        1. System proposes 320×480 to background
                        2. Background proposes 320×480 to padding
                        3. Padding subtracts 10pt edges → proposes 300×460 to text
                        4. Text reports 51×17
                        5. Padding adds 10pt edges → reports 71×37
                        6. Background proposes 71×37 to Color
                        7. Color accepts → reports 71×37
                        8. Background reports 71×37

                        Result: Final view is 71×37 centered in 320×480
                        """)
                        .font(.system(.caption, design: .monospaced))
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

// MARK: - Tab 2: ProposedViewSize

struct ProposedViewSizeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("ProposedViewSize")
                    .font(.title)
                    .bold()

                Text("iOS 16+ / macOS 13+")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What is ProposedViewSize?")
                            .font(.headline)

                        Text("""
                        ProposedViewSize is used in the Layout protocol (Advanced Layout chapter).
                        It represents the size a parent proposes to its child.

                        struct ProposedViewSize {
                            var width: CGFloat?
                            var height: CGFloat?
                        }

                        Key difference from CGSize: Both components are OPTIONAL!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("What does nil mean?")
                            .font(.headline)

                        Text("""
                        Proposing nil for a dimension means:
                        "The view can become its IDEAL SIZE in that dimension"

                        The ideal size is different for each view:
                        • Text: Size needed to render without wrapping
                        • Image: Intrinsic image dimensions
                        • Shape: Default 10×10 (from replacingUnspecifiedDimensions)
                        • Color: Would fill infinitely, but needs constraints
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: nil Proposal")
                            .font(.headline)

                        Text("""
                        Text("Hello, World!")
                            .fixedSize()

                        fixedSize() proposes nil×nil to the text.

                        Result: Text becomes its ideal size (no wrapping)

                        At different proposals:
                        • Proposed 25×50 → Reports 44×10 (ideal, draws out of bounds!)
                        • Proposed 50×50 → Reports 44×10 (ideal)
                        • Proposed 100×50 → Reports 44×10 (ideal)
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)

                        HStack(spacing: 20) {
                            VStack {
                                Text("With fixedSize")
                                    .font(.caption)
                                    .bold()

                                Text("Hello, World!")
                                    .fixedSize()
                                    .frame(width: 25, height: 50)
                                    .border(Color.red, width: 2)

                                Text("Overflows!")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }

                            VStack {
                                Text("Without fixedSize")
                                    .font(.caption)
                                    .bold()

                                Text("Hello, World!")
                                    .frame(width: 25, height: 50)
                                    .border(Color.blue, width: 2)

                                Text("Wraps")
                                    .font(.caption2)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("replacingUnspecifiedDimensions")
                            .font(.headline)

                        Text("""
                        When a view receives a proposal with nil components, it needs to convert to concrete values.

                        proposal.replacingUnspecifiedDimensions()

                        Default replacement: 10×10

                        This is why shapes in ScrollView default to 10pt on the scroll axis!

                        ScrollView {
                            Rectangle()  // Becomes 10pt tall (nil height → 10)
                        }

                        Fix with explicit size:
                        ScrollView {
                            Rectangle()
                                .frame(height: 200)
                        }
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

// MARK: - Tab 3: Debugging Layout

struct DebuggingLayoutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Debugging Layout")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Best Method: Borders")
                            .font(.headline)

                        Text("""
                        Adding .border() is the #1 way to debug layout issues!

                        It shows the actual size and position of a view.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)

                        VStack(spacing: 15) {
                            Text("Without border:")
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("Hello")
                                .padding()
                                .background(Color.teal)

                            Text("With border:")
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("Hello")
                                .padding()
                                .background(Color.teal)
                                .border(Color.red, width: 2)

                            Text("Now you can see the padding extends beyond the teal background!")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("GeometryReader for Size")
                            .font(.headline)

                        Text("""
                        You can overlay a GeometryReader to show the size:

                        Text("Hello")
                            .border(Color.red)
                            .overlay {
                                GeometryReader { proxy in
                                    Text("\\(proxy.size.width) × \\(proxy.size.height)")
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                        .padding(2)
                                        .background(Color.black.opacity(0.7))
                                }
                            }

                        But borders are usually enough!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Understanding View Trees")
                            .font(.headline)

                        Text("""
                        Remember: View modifiers wrap views!

                        Text("Hello")
                            .padding()
                            .background(Color.teal)

                        Creates this tree:

                        background
                        ├─ padding
                        │  └─ Text
                        └─ Color

                        Layout proceeds TOP-DOWN through this tree.
                        Understanding the tree helps predict layout behavior.
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Common Debug Patterns")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("1. Add borders to see actual size")
                                .font(.caption)
                            Text("2. Use different border colors at different levels")
                                .font(.caption)
                            Text("3. Check if view is clipped (.clipped() modifier)")
                                .font(.caption)
                            Text("4. Verify spacing in stacks (.spacing parameter)")
                                .font(.caption)
                            Text("5. Look for competing frame modifiers")
                                .font(.caption)
                        }
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

// MARK: - Tab 4: sizeThatFits Example

struct SizeThatFitsExampleView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("sizeThatFits Example")
                    .font(.title)
                    .bold()

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Understanding Container Layouts")
                            .font(.headline)

                        Text("""
                        Want to understand what a container (HStack, VStack, etc.) proposes to its children?

                        Use a custom shape with sizeThatFits that logs proposals!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Logging Shape")
                            .font(.headline)

                        Text("""
                        struct LoggingShape: Shape {
                            let name: String

                            func path(in rect: CGRect) -> Path {
                                Path { path in
                                    path.addRect(rect)
                                }
                            }

                            func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
                                let size = proposal.replacingUnspecifiedDimensions()
                                print("\\(name) proposed: \\(proposal.width ?? 0) × \\(proposal.height ?? 0)")
                                print("\\(name) reports: \\(size.width) × \\(size.height)")
                                return size
                            }
                        }
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Example: HStack Proposals")
                            .font(.headline)

                        Text("""
                        HStack {
                            LoggingShape(name: "A")
                                .fill(Color.red)
                            LoggingShape(name: "B")
                                .fill(Color.blue)
                            LoggingShape(name: "C")
                                .fill(Color.green)
                        }
                        .frame(width: 300, height: 100)

                        Console output:
                        A proposed: 100.0 × 100.0
                        A reports: 100.0 × 100.0
                        B proposed: 100.0 × 100.0
                        B reports: 100.0 × 100.0
                        C proposed: 100.0 × 100.0
                        C reports: 100.0 × 100.0

                        HStack divides 300pt width ÷ 3 subviews = 100pt each!
                        """)
                        .font(.caption)
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(5)
                    }
                }

                GroupBox {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Verifying Stack Algorithm")
                            .font(.headline)

                        Text("""
                        This technique is perfect for verifying:

                        • HStack/VStack layout algorithm (see HStackVStack.swift)
                        • How stacks probe flexibility (0 and ∞ proposals)
                        • layoutPriority() effects
                        • Spacing calculations

                        Note: sizeThatFits is part of the Shape protocol, not View protocol.
                        """)
                        .font(.caption)
                        .foregroundColor(.secondary)
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
        LayoutAlgorithmView()
            .tabItem { Label("Algorithm", systemImage: "1.circle") }

        ProposedViewSizeView()
            .tabItem { Label("ProposedViewSize", systemImage: "2.circle") }

        DebuggingLayoutView()
            .tabItem { Label("Debugging", systemImage: "3.circle") }

        SizeThatFitsExampleView()
            .tabItem { Label("sizeThatFits", systemImage: "4.circle") }
    }
}
