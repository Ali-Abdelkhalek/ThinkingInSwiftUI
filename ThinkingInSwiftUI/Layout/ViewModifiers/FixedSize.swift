//
//  FixedSizeExplained.swift
//  ThinkingInSwiftUI
//
//  Understanding the fixedSize() modifier
//  How it proposes nil to get ideal size and common use cases
//

import SwiftUI

struct FixedSizeExplained: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("fixedSize() Modifier")

                keyConceptSection

                sectionHeader("1. What fixedSize() Does")

                whatItDoes

                sectionHeader("2. Text Without fixedSize()")

                textWithoutFixedSize

                sectionHeader("3. Text With fixedSize()")

                textWithFixedSize

                sectionHeader("4. Horizontal vs Vertical")

                horizontalVsVertical

                sectionHeader("5. The Badge Problem")

                badgeProblem

                sectionHeader("6. Overflow and Clipping")

                overflowAndClipping

                sectionHeader("7. Practical Examples")

                practicalExamples
            }
            .padding()
        }
    }

    // MARK: - Key Concept

    private var keyConceptSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("The Core Behavior:")
                .font(.headline)

            conceptBox(
                icon: "∞",
                title: "Proposes nil × nil",
                description: "fixedSize() ignores what it's proposed and proposes nil to its child",
                color: .blue,
                details: [
                    "Receives proposal from parent (e.g., 100×50)",
                    "Ignores that proposal completely",
                    "Proposes nil×nil to child",
                    "Child becomes its ideal size",
                    "Reports child's ideal size to parent"
                ]
            )

            conceptBox(
                icon: "📏",
                title: "Makes Views Their Ideal Size",
                description: "Child sizes itself without constraints",
                color: .green,
                details: [
                    "Text becomes full width (no wrapping/truncation)",
                    "Images use intrinsic size",
                    "Views size to content",
                    "Can overflow parent's bounds!"
                ]
            )

            conceptBox(
                icon: "↔️",
                title: "Selective Application",
                description: "Can apply to one dimension only",
                color: .orange,
                details: [
                    "fixedSize() - both width and height",
                    "fixedSize(horizontal: true, vertical: false)",
                    "fixedSize(horizontal: false, vertical: true)",
                    "Mix constraints with ideal sizing"
                ]
            )
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    // MARK: - What It Does

    private var whatItDoes: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "The Proposal Flow",
                description: "How fixedSize() changes the proposal chain",
                code: ""
            ) {
                VStack(spacing: 16) {
                    // Without fixedSize
                    VStack(alignment: .leading, spacing: 8) {
                        Text("WITHOUT fixedSize():")
                            .fontWeight(.semibold)
                            .foregroundColor(.red)

                        VStack(alignment: .leading, spacing: 4) {
                            proposalStep("1", "Parent → Text: 100×50", .blue)
                            proposalStep("2", "Text wraps/truncates to fit 100×50", .blue)
                            proposalStep("3", "Text → Parent: 100×30 (wrapped)", .blue)
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)

                    // With fixedSize
                    VStack(alignment: .leading, spacing: 8) {
                        Text("WITH fixedSize():")
                            .fontWeight(.semibold)
                            .foregroundColor(.green)

                        VStack(alignment: .leading, spacing: 4) {
                            proposalStep("1", "Parent → fixedSize: 100×50", .green)
                            proposalStep("2", "fixedSize ignores and proposes nil×nil → Text", .green)
                            proposalStep("3", "Text becomes ideal size: 200×17", .green)
                            proposalStep("4", "fixedSize → Parent: 200×17", .green)
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)

                    Text("Key: fixedSize() breaks the constraint chain and lets child be ideal size!")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }

    // MARK: - Text Without fixedSize

    private var textWithoutFixedSize: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Text Adapts to Proposed Size",
                description: "Text wraps or truncates to fit",
                code: "Text(\"This is a longer text\").frame(width: 50)"
            ) {
                VStack(spacing: 16) {
                    // 25pt width
                    VStack(spacing: 8) {
                        Text("Width: 25pt")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .frame(width: 25)
                            .background(Color.blue.opacity(0.2))
                            .border(Color.blue, width: 2)

                        Text("Wraps to multiple lines")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    // 50pt width
                    VStack(spacing: 8) {
                        Text("Width: 50pt")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .frame(width: 50)
                            .background(Color.green.opacity(0.2))
                            .border(Color.green, width: 2)

                        Text("Still wraps, fewer lines")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    // 100pt width
                    VStack(spacing: 8) {
                        Text("Width: 100pt")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .frame(width: 100)
                            .background(Color.orange.opacity(0.2))
                            .border(Color.orange, width: 2)

                        Text("Wraps or fits on fewer lines")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Text("Text does ANYTHING to fit: wrapping, truncation, etc.")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }

    // MARK: - Text With fixedSize

    private var textWithFixedSize: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Text at Ideal Size (Can Overflow!)",
                description: "fixedSize() makes text its full ideal width",
                code: "Text(\"This is a longer text\").fixedSize().frame(width: 50)"
            ) {
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        Text("Frame: 25pt, Text with fixedSize()")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .fixedSize()
                            .frame(width: 25)
                            .background(Color.blue.opacity(0.2))
                            .border(Color.blue, width: 2)

                        Text("Text overflows! Becomes ideal size (~150pt)")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }

                    VStack(spacing: 8) {
                        Text("Frame: 50pt, Text with fixedSize()")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .fixedSize()
                            .frame(width: 50)
                            .background(Color.green.opacity(0.2))
                            .border(Color.green, width: 2)

                        Text("Still overflows! Same ideal size")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }

                    VStack(spacing: 8) {
                        Text("Frame: 100pt, Text with fixedSize()")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("This is a longer text")
                            .fixedSize()
                            .frame(width: 100)
                            .background(Color.purple.opacity(0.2))
                            .border(Color.purple, width: 2)

                        Text("Still overflows! Always ideal size")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }

                    Text("With fixedSize(), text ALWAYS becomes its ideal size, regardless of frame!")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                }
            }

            exampleCard(
                title: "Views Aren't Clipped by Default",
                description: "Overflow is visible unless you use .clipped()",
                code: ""
            ) {
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        Text("Without .clipped():")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("This is a longer text")
                            .fixedSize()
                            .frame(width: 50)
                            .background(Color.red.opacity(0.2))
                            .border(Color.red, width: 2)

                        Text("Text extends beyond border")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    VStack(spacing: 8) {
                        Text("With .clipped():")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("This is a longer text")
                            .fixedSize()
                            .frame(width: 50)
                            .background(Color.green.opacity(0.2))
                            .border(Color.green, width: 2)
                            .clipped()

                        Text("Text cropped at border")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }

    // MARK: - Horizontal vs Vertical

    private var horizontalVsVertical: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "fixedSize(horizontal:vertical:)",
                description: "Control which dimension becomes ideal size",
                code: ""
            ) {
                VStack(spacing: 16) {
                    // Both
                    VStack(alignment: .leading, spacing: 8) {
                        Text("fixedSize() - Both dimensions")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("This is a longer text that will wrap normally")
                            .fixedSize()
                            .frame(width: 100, height: 50)
                            .background(Color.blue.opacity(0.2))
                            .border(Color.blue, width: 2)

                        Text("• Width: ideal (~250pt, overflows)")
                            .font(.caption)
                        Text("• Height: ideal (~17pt, one line)")
                            .font(.caption)
                    }

                    // Horizontal only
                    VStack(alignment: .leading, spacing: 8) {
                        Text("fixedSize(horizontal: true, vertical: false)")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("This is a longer text that will wrap normally")
                            .fixedSize(horizontal: true, vertical: false)
                            .frame(width: 100, height: 50)
                            .background(Color.green.opacity(0.2))
                            .border(Color.green, width: 2)

                        Text("• Width: ideal (~250pt, overflows)")
                            .font(.caption)
                        Text("• Height: constrained (fits in 50pt)")
                            .font(.caption)
                    }

                    // Vertical only
                    VStack(alignment: .leading, spacing: 8) {
                        Text("fixedSize(horizontal: false, vertical: true)")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("This is a longer text that will wrap normally")
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: 100, height: 50)
                            .background(Color.orange.opacity(0.2))
                            .border(Color.orange, width: 2)

                        Text("• Width: constrained (wraps at 100pt)")
                            .font(.caption)
                        Text("• Height: ideal (grows beyond 50pt!)")
                            .font(.caption)
                    }

                    Text("Use horizontal/vertical to control which dimension breaks free of constraints!")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.purple)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }

    // MARK: - Badge Problem

    private var badgeProblem: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "The Badge Problem",
                description: "overlay proposes primary's size to secondary",
                code: ""
            ) {
                VStack(spacing: 16) {
                    Text("The Problem:")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Without fixedSize in badge:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("Hi")
                            .badgeBroken {
                                Text("2023").font(.caption)
                            }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("What happens:")
                                .fontWeight(.semibold)
                            Text("1. Text \"Hi\" size: ~16×17")
                            Text("2. overlay proposes 16×17 to badge")
                            Text("3. Badge \"2023\" forced into 16×17")
                            Text("4. Badge truncates: \"2...\"")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)

                    Divider()

                    Text("The Solution:")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("With fixedSize in badge:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("Hi")
                            .badge {
                                Text("2023").font(.caption)
                            }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("What happens:")
                                .fontWeight(.semibold)
                            Text("1. Text \"Hi\" size: ~16×17")
                            Text("2. overlay proposes 16×17 to badge")
                            Text("3. fixedSize() proposes nil×nil to \"2023\"")
                            Text("4. Badge becomes ideal size: ~35×15")
                            Text("5. Badge displays fully: \"2023\" ✓")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
                }
            }

            exampleCard(
                title: "Implementation Comparison",
                description: "The fix is just one line!",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("❌ Broken (badge truncates):")
                        .fontWeight(.semibold)
                        .foregroundColor(.red)

                    Text("""
                    func badgeBroken<Badge: View>(@ViewBuilder contents: () -> Badge) -> some View {
                        self.overlay(alignment: .topTrailing) {
                            contents()
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
                        }
                    }
                    """)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)

                    Divider()

                    Text("✅ Fixed (badge at ideal size):")
                        .fontWeight(.semibold)
                        .foregroundColor(.green)

                    Text("""
                    func badge<Badge: View>(@ViewBuilder contents: () -> Badge) -> some View {
                        self.overlay(alignment: .topTrailing) {
                            contents()
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
                                .fixedSize()  // ← This is the fix!
                        }
                    }
                    """)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
                }
            }

            exampleCard(
                title: "Badge Works on Any View",
                description: "Now it sizes correctly on small and large views",
                code: ""
            ) {
                VStack(spacing: 16) {
                    VStack(spacing: 8) {
                        Text("Small view:")
                            .font(.caption)

                        Text("Hi")
                            .badge {
                                Text("2023").font(.caption)
                            }
                    }

                    VStack(spacing: 8) {
                        Text("Large view:")
                            .font(.caption)

                        Text("Messages")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .badge {
                                Text("99+").font(.caption)
                            }
                    }

                    Text("Badge is always its ideal size, regardless of view it's applied to!")
                        .font(.caption)
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }

    // MARK: - Overflow and Clipping

    private var overflowAndClipping: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "When fixedSize() Causes Overflow",
                description: "Child can be larger than frame",
                code: ""
            ) {
                VStack(spacing: 16) {
                    HStack(spacing: 20) {
                        VStack(spacing: 8) {
                            Text("No clipping")
                                .font(.caption)

                            Text("Long text here")
                                .fixedSize()
                                .frame(width: 50, height: 30)
                                .background(Color.red.opacity(0.2))
                                .border(Color.red, width: 2)

                            Text("Overflows")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        VStack(spacing: 8) {
                            Text("With .clipped()")
                                .font(.caption)

                            Text("Long text here")
                                .fixedSize()
                                .frame(width: 50, height: 30)
                                .background(Color.green.opacity(0.2))
                                .border(Color.green, width: 2)
                                .clipped()

                            Text("Cropped")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }

                    Text("Use .clipped() to prevent visual overflow when needed")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }

    // MARK: - Practical Examples

    private var practicalExamples: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Button with Full-Width Text",
                description: "Prevent text truncation in buttons",
                code: ""
            ) {
                VStack(spacing: 12) {
                    VStack(spacing: 8) {
                        Text("Without fixedSize:")
                            .font(.caption)

                        Button("Very Long Button Title Here") {}
                            .buttonStyle(.borderedProminent)
                            .frame(width: 150)

                        Text("Text truncates")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    VStack(spacing: 8) {
                        Text("With fixedSize:")
                            .font(.caption)

                        Button("Very Long Button Title Here") {}
                            .buttonStyle(.borderedProminent)
                            .fixedSize()

                        Text("Button expands to fit text")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }

            exampleCard(
                title: "Multi-line Text with Fixed Width",
                description: "Height adapts to content, width constrained",
                code: "fixedSize(horizontal: false, vertical: true)"
            ) {
                VStack(spacing: 12) {
                    Text("This is a longer text that should wrap to multiple lines based on the width constraint but grow vertically to show all content")
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(width: 200)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)

                    Text("Width: 200pt (constrained)\nHeight: grows to fit all lines")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }

            exampleCard(
                title: "Horizontal Scrolling Text",
                description: "Text doesn't wrap, can scroll horizontally",
                code: "fixedSize(horizontal: true, vertical: false)"
            ) {
                VStack(spacing: 12) {
                    ScrollView(.horizontal) {
                        Text("This is a very long text that will not wrap and can be scrolled horizontally to see the full content")
                            .fixedSize(horizontal: true, vertical: false)
                            .padding()
                            .background(Color.green.opacity(0.2))
                    }
                    .frame(height: 60)
                    .border(Color.green, width: 2)

                    Text("Text doesn't wrap, scroll to see all →")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - Helper Views

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
    }

    private func exampleCard<Content: View>(
        title: String,
        description: String,
        code: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)

            if !code.isEmpty {
                Text(code)
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
            }

            content()
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    private func conceptBox(icon: String, title: String, description: String, color: Color, details: [String]) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(icon)
                .font(.largeTitle)
                .foregroundColor(color)

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(color)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)

                ForEach(details, id: \.self) { detail in
                    HStack(alignment: .top, spacing: 4) {
                        Text("•")
                        Text(detail)
                    }
                    .font(.caption)
                }
            }
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }

    private func proposalStep(_ number: String, _ text: String, _ color: Color) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Text("\(number).")
                .fontWeight(.semibold)
                .foregroundColor(color)
            Text(text)
                .font(.caption)
        }
    }
}

// MARK: - Badge Modifiers

extension View {
    // Broken version - badge truncates
    func badgeBroken<Badge: View>(@ViewBuilder contents: () -> Badge) -> some View {
        self.overlay(alignment: .topTrailing) {
            contents()
                .padding(3)
                .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
        }
    }

    // Fixed version - badge at ideal size
    func badge<Badge: View>(@ViewBuilder contents: () -> Badge) -> some View {
        self.overlay(alignment: .topTrailing) {
            contents()
                .padding(3)
                .background(RoundedRectangle(cornerRadius: 5).fill(.teal))
                .fixedSize()  // The fix!
        }
    }
}

// MARK: - Preview

#Preview {
    FixedSizeExplained()
}

/*
 FIXEDSIZE() SUMMARY:

 ## What It Does:

 Proposes nil×nil to its child, regardless of what it received:
 - Parent → fixedSize: 100×50
 - fixedSize → Child: nil×nil
 - Child becomes ideal size
 - fixedSize → Parent: child's ideal size

 ## Common Use Cases:

 1. **Prevent Text Truncation**
    Text("Long title").fixedSize()
    → Text becomes full width, no wrapping

 2. **Badges in Overlays**
    .overlay { Badge().fixedSize() }
    → Badge sizes itself, not constrained by overlay

 3. **Buttons with Long Titles**
    Button("Long").fixedSize()
    → Button expands to fit text

 4. **Selective Dimension Control**
    .fixedSize(horizontal: false, vertical: true)
    → Width constrained, height grows

 ## The Parameters:

 - fixedSize() → both dimensions ideal
 - fixedSize(horizontal: true, vertical: false) → width ideal, height constrained
 - fixedSize(horizontal: false, vertical: true) → width constrained, height ideal

 ## The Badge Problem:

 Without fixedSize():
 - overlay proposes primary's size (e.g., 16×17)
 - Badge forced into 16×17
 - Badge truncates: "2..."

 With fixedSize():
 - fixedSize proposes nil×nil
 - Badge becomes ideal size (~35×15)
 - Badge displays fully: "2023" ✓

 ## Overflow Behavior:

 fixedSize() can cause overflow!
 - Text becomes ideal size
 - May be larger than frame
 - Overflows visually by default
 - Use .clipped() to crop

 ## Key Insight:

 fixedSize() breaks the constraint chain:
 - Ignores proposed size
 - Lets child size itself
 - Reports child's ideal size
 - Child can overflow parent!

 This is the opposite of flexible frames:
 - Flexible frames constrain child
 - fixedSize liberates child
 */
