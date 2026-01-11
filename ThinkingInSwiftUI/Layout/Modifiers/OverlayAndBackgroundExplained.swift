//
//  OverlayAndBackgroundExplained.swift
//  ThinkingInSwiftUI
//
//  Understanding overlay and background modifiers
//  How they size themselves and their elegant two-step layout process
//

import SwiftUI

struct OverlayAndBackgroundExplained: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                sectionHeader("Overlay & Background Modifiers")

                keyConceptSection

                sectionHeader("1. The Two-Step Sizing Process")

                twoStepProcess

                sectionHeader("2. Basic Examples")

                basicExamples

                sectionHeader("3. With Padding")

                paddingExamples

                sectionHeader("4. Siblings Don't Move!")

                siblingsExample

                sectionHeader("5. Multiple Views (Implicit ZStack)")

                multipleViewsExample

                sectionHeader("6. Practical Examples")

                practicalExamples
            }
            .padding()
        }
    }

    // MARK: - Key Concept

    private var keyConceptSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("The Elegant Design:")
                .font(.headline)

            VStack(alignment: .leading, spacing: 12) {
                conceptBox(
                    title: "Layout Behavior",
                    description: "overlay and background work EXACTLY the same for layout",
                    details: [
                        "Size primary view first",
                        "Propose primary's size to secondary view",
                        "ALWAYS report primary's size (ignore secondary!)"
                    ],
                    color: .blue
                )

                conceptBox(
                    title: "Drawing Order",
                    description: "Only difference: what draws on top",
                    details: [
                        "background: Secondary BEHIND primary",
                        "overlay: Secondary ON TOP of primary",
                        "Both use same sizing logic"
                    ],
                    color: .orange
                )

                conceptBox(
                    title: "Key Insight",
                    description: "Secondary view NEVER affects layout!",
                    details: [
                        "Reported size = primary's size only",
                        "Secondary can be any size",
                        "Siblings positioned based on primary only"
                    ],
                    color: .green
                )
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }

    // MARK: - Two-Step Process

    private var twoStepProcess: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "The Two-Step Sizing Algorithm",
                description: "How background/overlay determine sizes",
                code: "Text(\"Hello\").background(Color.teal)"
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    stepBox(
                        number: "1",
                        title: "Size Primary First",
                        description: "Background/overlay asks primary view for its size",
                        example: "Text(\"Hello\") reports 44×17",
                        color: .blue
                    )

                    Text("↓")
                        .font(.title)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)

                    stepBox(
                        number: "2",
                        title: "Propose to Secondary",
                        description: "Takes primary's size and proposes it to secondary",
                        example: "Color.teal receives proposal: 44×17",
                        color: .green
                    )

                    Text("↓")
                        .font(.title)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)

                    stepBox(
                        number: "3",
                        title: "Report Primary's Size",
                        description: "ALWAYS reports primary's size, ignoring secondary!",
                        example: "background reports: 44×17 (Text's size)",
                        color: .orange
                    )

                    Text("Result: Secondary becomes exactly the same size as primary!")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.purple)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(8)
                }
            }

            exampleCard(
                title: "Visual Demonstration",
                description: "See the sizing in action",
                code: ""
            ) {
                VStack(spacing: 16) {
                    // Show the actual example
                    Text("Hello")
                        .background(Color.teal)
                        .overlay(
                            GeometryReader { geo in
                                Text("Size: \(Int(geo.size.width))×\(Int(geo.size.height))")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .offset(y: 20)
                            }
                        )

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Notice:")
                            .fontWeight(.semibold)
                        Text("• Text size: ~44×17")
                        Text("• Teal background: exactly 44×17")
                        Text("• Background perfectly fits text!")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - Basic Examples

    private var basicExamples: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Background - Behind Primary",
                description: "Secondary draws behind",
                code: "Text(\"Hello\").background(Color.teal)"
            ) {
                VStack(spacing: 12) {
                    Text("Hello")
                        .background(Color.teal)
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Text is primary (on top)")
                        Text("• Color is secondary (behind)")
                        Text("• Red border shows the size")
                        Text("• Background is exactly text size")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Overlay - On Top of Primary",
                description: "Secondary draws on top",
                code: "Text(\"Hello\").overlay(Color.red.opacity(0.3))"
            ) {
                VStack(spacing: 12) {
                    Text("Hello")
                        .overlay(Color.red.opacity(0.3))
                        .border(Color.blue, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Text is primary (behind)")
                        Text("• Color is secondary (on top)")
                        Text("• Blue border shows the size")
                        Text("• Overlay is exactly text size")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Both Together",
                description: "Layering order demonstration",
                code: ".background(Color.teal).overlay(Color.red.opacity(0.3))"
            ) {
                VStack(spacing: 12) {
                    Text("Hello")
                        .background(Color.teal)
                        .overlay(Color.red.opacity(0.3))
                        .border(Color.purple, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Layer order (bottom to top):")
                            .fontWeight(.semibold)
                        Text("1️⃣ Teal (background)")
                        Text("2️⃣ Text (primary)")
                        Text("3️⃣ Red overlay (overlay)")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - With Padding

    private var paddingExamples: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Background Adapts to Padding",
                description: "Secondary receives padded size",
                code: "Text(\"Hello\").padding(10).background(Color.teal)"
            ) {
                VStack(spacing: 12) {
                    Text("Hello")
                        .padding(10)
                        .background(Color.teal)
                        .border(Color.red, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Process:")
                            .fontWeight(.semibold)
                        Text("1. Text reports ~44×17")
                        Text("2. Padding adds 10pts each side → 64×37")
                        Text("3. Background proposed 64×37")
                        Text("4. Background becomes 64×37")
                        Text("5. Background reports 64×37")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Order Matters!",
                description: "Padding position affects background size",
                code: ""
            ) {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Padding BEFORE background:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("Hello")
                            .padding(10)
                            .background(Color.teal)
                            .border(Color.red, width: 2)

                        Text("Background includes padding")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Padding AFTER background:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("Hello")
                            .background(Color.teal)
                            .padding(10)
                            .border(Color.red, width: 2)

                        Text("Background only around text")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }

            exampleCard(
                title: "Negative Padding on Secondary",
                description: "Secondary can extend beyond primary",
                code: "Color.orange.padding(-3)"
            ) {
                VStack(spacing: 12) {
                    Text("Hello")
                        .background {
                            Color.orange
                                .padding(-3)
                        }
                        .border(Color.blue, width: 2)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Text size: ~44×17 (blue border)")
                        Text("• Background proposed: 44×17")
                        Text("• Background applies padding(-3)")
                        Text("• Background becomes: 50×23")
                        Text("• But reported size stays 44×17!")
                        Text("• Orange bleeds beyond border")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - Siblings Example

    private var siblingsExample: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Siblings Don't Move When Background Changes",
                description: "Reported size is ALWAYS primary's size",
                code: ""
            ) {
                SiblingsDemo()
            }

            exampleCard(
                title: "Why Siblings Don't Move",
                description: "Understanding the layout contract",
                code: ""
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("The Contract:")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)

                        Text("• background/overlay ALWAYS reports primary's size")
                        Text("• Secondary size is completely ignored")
                        Text("• Parent sees: \"This view is X×Y\"")
                        Text("• Even if secondary is larger/smaller")
                    }
                    .font(.caption)

                    Divider()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Example:")
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)

                        Text("Text(\"Hi\").background(Color.orange.padding(-10))")
                            .font(.system(.caption, design: .monospaced))

                        Text("• Text: 20×17")
                        Text("• Background with padding(-10): 40×37")
                        Text("• Reported to parent: 20×17 (text's size!)")
                        Text("• Sibling positioned at 20pt mark")
                    }
                    .font(.caption)

                    Text("This is why the .highlight() modifier doesn't affect layout!")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                        .padding(.top, 4)
                }
            }
        }
    }

    // MARK: - Multiple Views

    private var multipleViewsExample: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "Multiple Views = Implicit ZStack",
                description: "Secondary view can contain multiple views",
                code: ""
            ) {
                VStack(spacing: 16) {
                    Text("Hello")
                        .background {
                            Color.teal
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .padding(5)
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Code:")
                            .fontWeight(.semibold)

                        Text("""
                        .background {
                            Color.teal
                            Circle().stroke()
                        }
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)

                        Text("Multiple views wrapped in implicit ZStack")
                            .foregroundColor(.secondary)
                    }
                    .font(.caption)
                }
            }

            exampleCard(
                title: "Layering with Multiple Views",
                description: "Order determines drawing order",
                code: ""
            ) {
                VStack(spacing: 12) {
                    Text("Layered")
                        .foregroundColor(.white)
                        .background {
                            Color.blue
                            Circle()
                                .fill(Color.red)
                                .padding(10)
                            Rectangle()
                                .stroke(Color.yellow, lineWidth: 3)
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Drawing order (back to front):")
                            .fontWeight(.semibold)
                        Text("1️⃣ Blue color (first in background)")
                        Text("2️⃣ Red circle (second)")
                        Text("3️⃣ Yellow border (third)")
                        Text("4️⃣ Text \"Layered\" (primary, on top)")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
        }
    }

    // MARK: - Practical Examples

    private var practicalExamples: some View {
        VStack(spacing: 20) {
            exampleCard(
                title: "The highlight() Modifier",
                description: "From the book - doesn't affect sibling layout",
                code: ""
            ) {
                VStack(spacing: 12) {
                    HStack {
                        Text("Normal")
                            .highlight(enabled: false)

                        Text("Highlighted")
                            .highlight(enabled: true)

                        Text("Normal")
                            .highlight(enabled: false)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Implementation:")
                            .fontWeight(.semibold)

                        Text("""
                        func highlight(enabled: Bool = true) -> some View {
                            background {
                                if enabled {
                                    Color.orange.padding(-3)
                                }
                            }
                        }
                        """)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)

                        Text("Notice: All three texts stay in the same position! The orange background bleeds but doesn't affect layout.")
                            .foregroundColor(.orange)
                    }
                    .font(.caption)
                }
            }

            exampleCard(
                title: "Badge with Overlay",
                description: "Number badge in corner",
                code: ""
            ) {
                VStack(spacing: 12) {
                    Text("Messages")
                        .font(.title3)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .overlay(alignment: .topTrailing) {
                            Text("5")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(6)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 8, y: -8)
                        }

                    Text("Badge is in overlay, doesn't affect button size")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            exampleCard(
                title: "Border with Background",
                description: "Custom border effect",
                code: ""
            ) {
                VStack(spacing: 12) {
                    Text("Custom Border")
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    LinearGradient(
                                        colors: [.blue, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 3
                                )
                        }

                    Text("Gradient border using background")
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

    private func conceptBox(title: String, description: String, details: [String], color: Color) -> some View {
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
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }

    private func stepBox(number: String, title: String, description: String, example: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(number)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(color)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(color)

                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(example)
                    .font(.system(.caption, design: .monospaced))
                    .padding(6)
                    .background(color.opacity(0.1))
                    .cornerRadius(4)
            }
        }
        .padding()
        .background(color.opacity(0.05))
        .cornerRadius(8)
    }
}

// MARK: - Siblings Demo

struct SiblingsDemo: View {
    @State private var highlightEnabled = false

    var body: some View {
        VStack(spacing: 16) {
            Toggle("Enable Highlight", isOn: $highlightEnabled)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

            VStack(spacing: 12) {
                Text("Watch the siblings:")
                    .font(.caption)
                    .fontWeight(.semibold)

                HStack(spacing: 0) {
                    Text("Before")
                        .padding(8)
                        .background(Color.gray.opacity(0.2))

                    Text("Target")
                        .padding(8)
                        .highlight(enabled: highlightEnabled)
                        .background(Color.gray.opacity(0.2))

                    Text("After")
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                }
                .border(Color.blue, width: 2)

                Text(highlightEnabled ?
                    "Orange background bleeds out, but siblings stay put!" :
                    "Toggle to see - siblings won't move!"
                )
                .font(.caption)
                .foregroundColor(highlightEnabled ? .orange : .secondary)
                .multilineTextAlignment(.center)
            }
        }
    }
}

// MARK: - Highlight Modifier

extension View {
    func highlight(enabled: Bool = true) -> some View {
        background {
            if enabled {
                Color.orange
                    .padding(-3)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    OverlayAndBackgroundExplained()
}

/*
 OVERLAY AND BACKGROUND SUMMARY:

 ## Layout Behavior (Identical for Both):

 1. Size primary view first
 2. Propose primary's size to secondary view
 3. ALWAYS report primary's size (ignore secondary!)

 ## Drawing Order (Only Difference):

 - background: Secondary draws BEHIND primary
 - overlay: Secondary draws ON TOP of primary

 ## Key Insights:

 ### The Elegant Two-Step Process:

 Step 1: "How big are you?" → Primary reports size
 Step 2: "Be this size" → Proposes to secondary
 Step 3: "I'm the primary's size" → Reports to parent

 This makes secondary automatically match primary's size!

 ### Siblings Never Move:

 Because background/overlay ALWAYS reports primary's size:
 - Even if secondary is huge (with negative padding)
 - Even if secondary is tiny
 - Even if secondary is completely different size

 Parent only sees primary's size → siblings positioned accordingly

 ### Multiple Views → Implicit ZStack:

 When secondary has multiple views:

 .background {
     Color.blue
     Circle()
     Rectangle()
 }

 These get wrapped in an implicit ZStack!

 ## Common Patterns:

 1. Perfect-fit backgrounds:
    .background(Color.teal) // Exactly matches view size

 2. Bleeding backgrounds:
    .background { Color.orange.padding(-3) } // Extends beyond

 3. Badges:
    .overlay(alignment: .topTrailing) { Badge() }

 4. Custom borders:
    .background { RoundedRectangle().stroke() }

 ## The Highlight Pattern:

 extension View {
     func highlight(enabled: Bool = true) -> some View {
         background {
             if enabled {
                 Color.orange.padding(-3)
             }
         }
     }
 }

 This doesn't affect layout because:
 - background reports primary's size
 - Even though orange bleeds beyond
 - Siblings stay in place!
 */
